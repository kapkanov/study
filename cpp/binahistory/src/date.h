#include <string>
#include <vector>
#include <string>
#include <memory>
#include <ctime>


void                     date_validate(const std::string &str);
std::unique_ptr<std::tm> date_from_str(const std::string &str);
std::vector<std::string> date_range(const std::string &start, const std::string &end);

