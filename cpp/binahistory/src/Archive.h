#include <string>
#include <sstream>
#include <fstream>
#include <pqxx/pqxx>
#include "date.h"
#include "curl.h"
#include "file.h"
#include "unzip.h"

//
#include <iostream>
//


const std::string POSTGRES_URL = std::string("postgresql://")
  + std::getenv("POSTGRES_USER") + ":" + std::getenv("POSTGRES_PASSWORD")
  + "@" + std::getenv("POSTGRES_HOST") + ":5432/" + std::getenv("POSTGRES_DB") + "?connect_timeout=3";


class Archive {

private:
  std::string      symbol;
  std::string      filename;
  std::string      year_month_day;
  std::string      url;
  std::string      sha256_hex;
  std::int64_t     id;
  pqxx::connection conn;
  bool             downloaded;
  bool             verified;
  bool             extracted;
  bool             ingested;
  // bool        deleted;


public:
  Archive(const std::string &SYMBOL, const std::string &date) : conn(POSTGRES_URL) {
    date_validate(date);

    symbol         = SYMBOL;
    filename       = "downloads/" + symbol + "-trades-" + date + ".zip";
    year_month_day = date;
    url            = "https://data.binance.vision/data/spot/daily/trades/" + symbol 
      + "/" + symbol + "-trades-" + year_month_day + ".zip";
    sha256_hex     = "";
    id             = 0;
    verified       = extracted = downloaded = ingested = false;
    // conn           = pqxx::connection(std::string("postgresql://")
    //   + std::getenv("POSTGRES_USER") + ":" + std::getenv("POSTGRES_PASSWORD")
    //   + "@127.0.0.1:5432/" + std::getenv("POSTGRES_DB") + "?connect_timeout=3");
  }


  Archive &download(const bool redownload=false) {
    if (downloaded && redownload == false)
      return *this;

    if (redownload) {
      curl_download(url, filename);
      curl_download(url + ".CHECKSUM", filename + ".CHECKSUM");
    }

    if (file_exists(filename) == false)
      curl_download(url, filename);
    if (file_exists(filename + ".CHECKSUM") == false)
      curl_download(url, filename + ".CHECKSUM");

    if (file_exists(filename) && file_exists(filename + ".CHECKSUM"))
      downloaded = true;

    return *this;
  }


  Archive &verify(void) {
    if (verified)
      return *this;

    sha256_hex = file_sha256_verify(filename, filename + ".CHECKSUM");
    verified   = sha256_hex.empty() == false;

    return *this;
  }


  Archive &unzip(void) {
    ::unzip(filename);
    extracted = true;
    return *this;
  }


  void ingest(void) {
    auto transaction = pqxx::work(conn);

    std::string query = R"(
      INSERT INTO archives (symbol, filename, year_month_day, url, sha256_hex, ingested)
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING id;
    )";

    pqxx::result res = transaction.exec_params(query, symbol, filename, year_month_day, url, sha256_hex, false);

    id = res[0]["id"].as<std::int64_t>();

    query = R"(
      INSERT INTO trades (archive_id, id, price, qty, quoteQty, time, isBuyerMaker, isBestMatch)
      VALUES
    )";

    std::string csv = filename.substr(0, filename.find_last_of(".")) + ".csv";
    auto        ifs = std::ifstream(csv, std::ios::binary);

    for (std::string line; std::getline(ifs, line);) {
      query += "($1," + line + "),";
    }
    query.pop_back();
    query += ";";

    transaction.exec_params(query, id);
    transaction.commit();
  }


  static void init(void) {
    mkdir("downloads");
  }


  void debug(void) const {
    std::cout << "symbol = " << symbol << std::endl;
    std::cout << "filename = " << filename << std::endl;
    std::cout << "year_month_day = " << year_month_day << std::endl;
    std::cout << "url = " << url << std::endl;
    std::cout << "sha256_hex = " << sha256_hex << std::endl;
    std::cout << "downloaded = " << downloaded << std::endl;
    std::cout << "verified = " << verified << std::endl;
    std::cout << "extracted = " << extracted << std::endl;
    // std::cout << "deleted = " << deleted << std::endl;
    std::cout << "ingested = " << ingested << std::endl;
  }
};

