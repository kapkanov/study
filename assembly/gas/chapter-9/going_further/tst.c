#include <stdio.h>
#include <stdlib.h>

int main(void) {
  char *str;

  str = malloc(128);

  str[0] = 'h';
  str[1] = 'o';
  str[2] = 'l';
  str[3] = 'a';
  str[4] = 0;

  printf("%s\n", str);

  free(str);

  return 0;
}
