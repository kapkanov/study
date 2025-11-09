#include <string>


bool        file_exists(const std::string &path);
void        mkdir(const std::string &filename);
std::string file_read_all(const std::string &filename);
std::string file_sha256_hex(const std::string &filename);
std::string file_sha256_verify(const std::string &filename, const std::string &filename_checksum);

