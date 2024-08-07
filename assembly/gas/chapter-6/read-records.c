#include <fcntl.h>
#include <unistd.h>

#define RECLEN 324

int main(void) {
  char                  buf[RECLEN];
  register unsigned int j;
  const char            fname[] = "test.dat\0";
  const char            newline = '\n';
  const int             fd      = open(fname, O_RDONLY, 0644);

  while (read(fd, buf, RECLEN)) {
    for (j = 0; j < RECLEN && buf[j]; j++);
    write(1, buf, j);
    write(1, &newline, 1);
  }

  return 0;
}
