.section .data


.section .text

.globl _start

_start:
  pushl $4
  call  factorial
  addl  $4,       %esp
  movl  %eax,     %ebx
  movl  $1,       %eax
  int   $0x80


# %eax - return value, factorial
# %ebx - current multiplier
.type factorial,@function

factorial:
  pushl %ebp
  movl  %esp,    %ebp
  movl  8(%ebp), %eax
  movl  %eax,    %ebx
  decl  %ebx

factorial_loop:
  cmpl  $1,      %ebx
  je    factorial_exit
  imull %ebx,    %eax
  decl  %ebx
  jmp   factorial_loop

factorial_exit:
  movl  %ebp,     %esp
  popl  %ebp
  ret

