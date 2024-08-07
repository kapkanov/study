.globl isneg
.type  isneg, @function
isneg:
  movl $0,        %eax
  cmpl $0,        4(%esp)
  jge  isneg_exit
  movl $1,        %eax
isneg_exit:
  ret

.globl _start
.section .text
_start:
  pushl $-1
  call  isneg

  movl  %eax, %ebx
  movl  $1,   %eax
  int   $0x80
