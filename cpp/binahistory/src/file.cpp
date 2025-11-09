#include <fstream>
#include <filesystem>
#include <stdexcept>
#include <iostream>
#include <limits>
#include <openssl/evp.h>
#include <sstream>
#include "file.h"


bool file_exists(const std::string &path) {
  return std::filesystem::exists(path) && std::filesystem::is_regular_file(path);
}


void mkdir(const std::string &filename) {
  std::filesystem::path path(filename);

  bool path_exist = std::filesystem::is_directory(path);

  if (path_exist) {
    std::cout << "[INFO] mkdir(" << filename << "): Using already existing directory " << std::endl;
    return;
  }

  bool path_created = std::filesystem::create_directory(path);

  if (path_created) {
    std::cout << "[INFO] mkdir(" << filename << "): Created directory" << std::endl;
    return;
  }

  throw std::runtime_error("mkdir(\"" + filename + "\"): Failed to create a directory");
}


std::string file_read_all(const std::string &filename) {
  std::ifstream stream_input(filename, std::ios::in | std::ios::binary);

  if (stream_input.is_open() == false) {
    throw std::runtime_error("file_read_all(\"" + filename + "\"): failed to open a file");
  }

  std::filesystem::path path(filename);
  std::uintmax_t file_size = std::filesystem::file_size(path);

  if (file_size > (std::uintmax_t)std::numeric_limits<std::streamsize>::max()) {
    throw std::runtime_error("file_read_all(\"" + filename + "\"): file is too large");
  }

  auto buffer = std::string(file_size, '\0');

  stream_input.read(&buffer[0], (std::streamsize)file_size);

  return buffer;
}


std::string file_sha256_hex(const std::string &filename) {
  const std::string buffer = file_read_all(filename);
  unsigned char     md_value[EVP_MAX_MD_SIZE];
  unsigned int      md_len;

  EVP_MD_CTX *mdctx = EVP_MD_CTX_new();
  if (!EVP_DigestInit_ex2(mdctx, EVP_sha256(), nullptr)) {
    EVP_MD_CTX_free(mdctx);
    throw std::runtime_error("file_sha256_hex(\"" + filename + "\"): Message digest init failed");
  }

  if (!EVP_DigestUpdate(mdctx, &buffer[0], buffer.length())) {
    EVP_MD_CTX_free(mdctx);
    throw std::runtime_error("file_sha256_hex(\"" + filename + "\"): Message digest update failed");
  }

  if (!EVP_DigestFinal_ex(mdctx, md_value, &md_len)) {
    EVP_MD_CTX_free(mdctx);
    throw std::runtime_error("file_sha256_hex(\"" + filename + "\"): Message digest finalization failed");
  }

  EVP_MD_CTX_free(mdctx);

  std::ostringstream oss;
  for (int j = 0; j < md_len; j++) {
    oss << std::setfill('0') << std::setw(2) << std::hex << static_cast<int>(md_value[j]);
  }

  return oss.str();
}


std::string file_sha256_verify(const std::string &filename, const std::string &filename_checksum) {
  std::ifstream stream_input_checksum(filename_checksum, std::ios::in | std::ios::binary);

  if (stream_input_checksum.is_open() == false) {
    throw std::runtime_error("[ERROR] file_sha256_verify: Failed to open " + filename_checksum);
  }

  std::string hex_expected;
  std::string filename_expected;

  stream_input_checksum >> hex_expected >> filename_expected;

  std::string filename_actual = filename.substr(filename.find_last_of("/\\") + 1);

  if (filename_expected.compare(filename_actual) != 0) {
    std::cout << "[ERROR] file_sha256_verify: filename " << filename
      << " does not correspond to filename in checksum file " << filename_checksum
      << " which is " << filename_expected << std::endl;
    return "";
  }

  std::string hex_actual = file_sha256_hex(filename);

  if (hex_actual.compare(hex_expected) != 0) {
    std::cout << "[ERROR] file_sha256_verify: hash of the " << filename
      << " doesn't match hash in " << filename_checksum << std::endl;
    return "";
  }

  return hex_actual;
}

