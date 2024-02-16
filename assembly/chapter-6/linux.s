# Interrupts
.set INT_SYS,        0x80
.set NR_EXIT,           1
.set NR_READ,           3
.set NR_WRITE,          4
.set NR_OPEN,           5
.set NR_CLOSE,          6
.set NR_LSEEK,         19

# File macros
.set FMODE_RDONLY,     00
.set FMODE_WRONLY,     01
.set FMODE_RDWR,       02
.set FMODE_TRUNC,   01000
.set FMODE_APPEND,  02000
.set FMODE_CREAT,    0100

.set FPERM,          0644

.set STDIN,             0
.set STDOUT,            1
.set STDERR,            2

.set SEEK_SET,          0
.set SEEK_CUR,          1
.set SEEK_END,          2
.set SEEK_DATA,         3
.set SEEK_HOLE,         4
