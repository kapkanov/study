.include "linux.s"
.include "stack.s"
.include "recdef.s"

# Read a record in to the buffer
# 2 param - pointer to the buffer
# 1 param - file descriptor
.type  recread,@function
.globl recread

recread:
  pushl %ebp
  movl  %esp,          %ebp
  movl  $NR_READ,      %eax
  movl  PARAM_1(%ebp), %ebx
  movl  PARAM_2(%ebp), %ecx
  movl  $RECLEN,       %edx
  int   $INT_SYS
  movl  %ebp,          %esp
  popl  %ebp
  ret
