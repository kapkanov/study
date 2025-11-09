#include "date.h"
#include <iomanip>
#include <stdexcept>
#include <sstream>
#include <climits>


const int DAY_SECONDS = 24 * 3600;


void date_validate(const std::string &str) {
  // TODO
  if (false) {
    throw std::runtime_error("date_validate(\"" + str + "\") failed. The string should be in format %Y-%m-%d");
  }
}

std::unique_ptr<std::tm> date_from_str(const std::string &str) {
  auto date = std::make_unique<std::tm>(std::tm{});

  date->tm_isdst = -1;
  date->tm_hour  = 12;

  auto ss = std::istringstream(str);
  ss >> std::get_time(date.get(), "%Y-%m-%d");

  return date;
}


std::vector<std::string> date_range(const std::string &start, const std::string &end) {
  if (start.empty()) {
    throw std::runtime_error("date_range: `start` argument is empty");
  }
  if (end.empty()) {
    throw std::runtime_error("date_range: `end` argument is empty");
  }

  auto       date     = date_from_str(start);
  const auto date_end = date_from_str(end);

  std::vector<std::string> range;

  std::time_t       epoch     = std::mktime(date.get());
  const std::time_t epoch_end = std::mktime(date_end.get());

  for (int j = 0; j < INT_MAX - 1 && epoch <= epoch_end; j++) {
    std::ostringstream oss;
    oss << std::put_time(std::localtime(&epoch), "%Y-%m-%d");
    range.push_back(oss.str());
    epoch += DAY_SECONDS;
  }

  return range;
}

