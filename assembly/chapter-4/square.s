.section .data
square_test_data:
  .long 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

.section .text
.globl _start
_start:
#  pushl $6
#  call  square
#  addl  $4,    %esp
#  mov   %eax,  %ebx
#  mov   $1,    %eax
#  int   $0x80
  call square_test
  movl %eax, %ebx
  movl $1,   %eax
  int  $0x80

# 1 parameter - long number
# %eax        - square of the argument, result
# Return -1 on failure in %eax
.type square,@function
square:
  pushl %ebp
  movl  %esp,    %ebp
  movl  8(%ebp), %eax
  imull %eax,    %eax
  movl  %ebp,    %esp
  popl  %ebp
  ret

.type square_test,@function
square_test:
  movl  $0,                        %edi
  pushl %ebp
  movl  %esp,                      %ebp
square_test_loop:
  cmpl  $16,                       %edi
  je    square_test_exit
  movl  square_test_data(,%edi,4), %ebx
  incl  %edi
  pushl %ebx
  call  square
  addl  $4,                        %esp
  imull %ebx,                      %ebx
  # addl  $1,                        %ebx # test failure case
  cmpl  %ebx,                      %eax
  je    square_test_loop
  movl  $-1,                       %eax
square_test_exit:
  movl  %ebp,                      %esp
  popl  %ebp
  ret
