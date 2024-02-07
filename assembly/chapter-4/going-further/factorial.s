.section .data


.section .text

.globl _start

_start:
  movl $5,   %ebx
  call factorial
  movl %eax, %ebx
  movl $1,   %eax
  int  $0x80

# %eax - return value, factorial of the number
# %ebx - number, parameter
# %edi - local variable, current value of multiplier
.type factorial,@function

factorial:
  movl %ebx, %eax
  movl %ebx, %edi
  decl %edi

factorial_loop:
  cmpl $1,    %edi
  je   factorial_exit
  imull %edi, %eax
  decl  %edi
  jmp   factorial_loop

factorial_exit:
  ret
