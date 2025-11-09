#include <string>
#include "Archive.h"
#include "date.h"


int main(void) {
  const std::string DATE_START = std::getenv("APP_DATE_START");
  const std::string DATE_END   = std::getenv("APP_DATE_END");
  const std::string SYMBOL     = std::getenv("APP_SYMBOL");

  Archive::init();

  for (std::string &date : date_range(DATE_START, DATE_END)) {
    auto arch = Archive(SYMBOL, date);
    // arch.download().verify().unzip().ingest();
    arch.download().unzip().ingest();
  }

  std::cin.get();

  return 0;
}

