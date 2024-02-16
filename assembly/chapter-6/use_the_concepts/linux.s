# Interrupts
.set INT_SYS,   0x80
.set NR_EXIT,   0x1
.set NR_READ,   0x3
.set NR_WRITE,  0x4
.set NR_OPEN,   0x5
.set NR_CLOSE,  0x6

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
