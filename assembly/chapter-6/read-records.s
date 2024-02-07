# 2 param - pointer to the buffer
# 1 param - file descriptor
.globl recread,@function

recread:
  pushl %ebp
  movl  %esp,         %ebp
  movl PARAM_1(%ebp), %ebx
  movl PARAM_2(%ebp), %ecx
  movl $RECLEN,       %edx
  int  $INT_SYS
  movl %ebp,          %esp
  popl %ebp
  ret
