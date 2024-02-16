.include "stack.s"
.include "linux.s"

# PARAM_1 - file descriptor
.globl wnewline
.type wnewline,@function

.section .data
newline:
  .ascii "\n"

wnewline:
  pushl %ebp
  movl  %esp,          %ebp
  movl  $NR_WRITE,     %eax
  movl  PARAM_1(%ebp), %ebx
  movl  $newline,      %ecx
  movl  $1,            %edx
  int   $INT_SYS
  movl  %ebp,          %esp
  popl  %ebp
  ret
