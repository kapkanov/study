.section .data

# %ebp - base pointer
# %esp - top stack pointer
# %eax - return value of function
# power(base number, power value)


.section .text
.globl _start
_start:
  pushl $3    # power
  pushl $2    # base
  call  power
  movl  %eax, %ebx
  movl  $1,   %eax
  int   $0x80  # exit

# %eax - Base number. First parameter of the function
# %ebx - Power value. Second parameter of the function
# %ecx - Multiplier
.type power,@function
power:
  pushl %ebp
  movl  %esp,    %ebp
  movl  4(%ebp), %eax
  movl  8(%ebp), %ebx
  movl  %eax,    %ecx
  power_loop:
    cmpl  $1,    %ebx
    je    power_exit
    imull %ecx,  %eax
    subl  $1,    %ebx
    jmp   power_loop
    
power_exit:
  popl %ebp
  ret
