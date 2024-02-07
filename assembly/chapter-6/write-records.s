# Task:
# - Open the file
# - Write three records
# - Close the file

# 2 param - pointer to the buffer
# 1 param - file descriptor
.type recwrite,@function
.globl recwrite

recwrite:
  pushl %ebp
  movl  %esp,          %ebp
  movl  $NR_WRITE,     %eax
  movl  PARAM_1(%ebp), %ebx
  movl  PARAM_2(%ebp), %ecx
  movl  $RECLEN,       %edx
  int   $INT_SYS
  movl  %ebp,          %esp
  popl  %ebp
  ret
