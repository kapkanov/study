#include <string>
#include <curl/curl.h>
#include <stdexcept>
#include <fstream>


static size_t WriteCallback(void *contents, size_t size, size_t nmemb, void *userp)
{
    ((std::string *)userp)->append((char *)contents, size * nmemb);
    return size * nmemb;
}


void curl_download(const std::string &url, const std::string &filename, const bool verbose=false) {
  CURL *curl;

  curl = curl_easy_init();
  for (int j = 0; j < 3 && curl == 0; j++)
    curl = curl_easy_init();
  if (curl == 0)
    throw std::runtime_error("curl_download(\"" + url + "\"): Failed to init curl");

  CURLcode    res;
  std::string readBuffer;

  if (verbose)
    curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
  curl_easy_setopt(curl, CURLOPT_URL, &url[0]);
  curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
  curl_easy_setopt(curl, CURLOPT_WRITEDATA, &readBuffer);

  res = curl_easy_perform(curl);
  curl_easy_cleanup(curl);

  if (res != CURLE_OK)
    throw std::runtime_error("curl_download(\"" + url + "\"): Request failed. Check docs for error code " + std::to_string(res));

  std::ofstream(filename, std::ios::binary | std::ios::trunc) << readBuffer;
}

