#include <stdexcept>
#include <limits>
#include <fstream>
#include "unzip.h"

//
#include <iostream>
//

std::string unzip(const std::string &filename) {
  zip_t *za;
  int    err;

  za = zip_open(filename.c_str(), ZIP_RDONLY, &err);

  if (za == nullptr) {
    zip_error_t error;
    zip_error_init_with_code(&error, err);
    throw std::runtime_error("zip_unzip(\"" + filename + "\"): Cannot open zip archive. " + zip_error_strerror(&error));
  }

  // TODO: add check whether the file exists via zip_name_locate
  std::string zfname = filename.substr(filename.find_last_of("/\\") + 1); // get the basename
  zfname = zfname.substr(0, zfname.find_last_of(".")) + ".csv";           // change the extension

  zip_file_t *zf = zip_fopen(za, zfname.c_str(), 0);

  if (zf == nullptr) {
    zip_close(za);
    throw std::runtime_error("zip_unzip(\"" + filename + "\"): Cannot open file in a zip archive. ");
  }


  std::string buffer;
  auto        contents = std::string(BUFFER_SIZE, '\0');
  std::size_t contents_size = 0;
  for (; (contents_size = zip_fread(zf, &contents[0], BUFFER_SIZE)) != 0;) {
    buffer.append(contents, 0, contents_size);
  }
/*
  auto buffer      = std::string(BUFFER_SIZE, '\0');
  int  buffer_size = zip_fread(zf, &buffer[0], BUFFER_SIZE);

  if (buffer_size < buffer.size()) {
    buffer.resize(buffer_size);
  } else {
    // TODO: resize a buffer and read the last characters!
  }
  */

  auto fs = std::ofstream("downloads/" + zfname, std::ios::binary | std::ios::trunc);
  fs.write(&buffer[0], buffer.size());

  zip_close(za);

  return buffer;
}

