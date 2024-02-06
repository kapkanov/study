.section .data
  fname:
    .ascii "heynow.txt\0"
  msg:
    .ascii "Hey diddle diddle!\0"


.set NR_EXIT,  0x1
.set NR_WRITE, 0x4
.set NR_OPEN,  0x5
.set NR_CLOSE, 0x6
.set INT_SYS,  0x80
.set FFLAGS,   03101 # O_WRONLY(01) | O_TRUNC(01000) | O_APPEND(02000) | O_CREAT(0100)
.set FMODE,    0644

.section .text
.globl _start

_start:
  # Open file
  movl $fname,    %ebx
  movl $FFLAGS,   %ecx
  movl $FMODE,    %edx
  movl $NR_OPEN,  %eax
  int  $INT_SYS

  # Write to the file
  movl %eax,      %ebx # file descriptor
  movl $NR_WRITE, %eax
  movl $msg,      %ecx
  movl $18,       %edx
  int  $INT_SYS

  # Close the file
  movl $NR_CLOSE, %eax
  int  $INT_SYS

  # Exit the program
  movl $NR_EXIT,  %eax
  int  $INT_SYS
