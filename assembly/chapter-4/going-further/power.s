.section .data


.section .text

.globl _start

_start:
  movl $2,   %ebx
  movl $3,   %ecx
  call power
  movl %eax, %ebx
  movl $1,   %eax
  int  $0x80

# Return power of number
# %eax - return value
# %ebx - number
# %ecx - power
# %edi - local variable, how many multiplies left
.type power,@function

power:
  movl %ecx, %edi
  movl %ebx, %eax

power_loop:
  cmpl  $1,   %edi
  je    power_exit
  imull %ebx, %eax
  decl  %edi
  jmp   power_loop

power_exit:
  ret
