.section .data

data_items:
  .long 3,67,34,222,45,75,54,34,44,33,22,11,66,0

data_two:
  .long 45,75,54,34,44,33,22,11,66,0

data_three:
  .long 8,1,2,6,74,34,2,11,7,0


.section .text

#.globl _start
#_start:
#  movl $0,                  %edi
#  movl data_items(,%edi,4), %eax
#  movl %eax,                %ebx

#start_loop:
#  cmpl $0,                  %eax
#  je   loop_exit
#  incl %edi
#  movl data_items(,%edi,4), %eax
#  cmpl %ebx,                %eax
#  jle  start_loop
#  movl %eax,                %ebx
#  jmp start_loop

#loop_exit:
#  movl $1,                  %eax
#  int $0x80

.globl _start
_start:
  pushl $data_items
  call  max
  addl  $4,        %esp
  pushl $data_two
  call  max
  addl  $4,        %esp
  pushl $data_three
  call  max
  addl  $4,        %esp
  movl  $1,        %eax
  int   $0x80


# Return maximum value from set of numbers
# %eax        - current value of the data set
# %ebx        - return value, largest number
# %ecx        - pointer to the data set
# 1 parameter - pointer to set of numbers
# 0           - terminating number, indicating end of the set
# %edi        - iterator, index of data set

.type max,@function

max:
  pushl %ebp
  movl  %esp,             %ebp
  movl  8(%ebp),          %ecx
  movl  $0,               %edi
  movl  (%ecx,%edi,4),    %eax
  movl  %eax,             %ebx

max_loop:
  cmpl $0,                %eax
  je   max_exit
  incl %edi
  movl (%ecx,%edi,4),     %eax
  cmpl %ebx,              %eax
  jle  max_loop
  movl %eax,              %ebx
  jmp  max_loop
  
max_exit:
  movl %ebp,              %esp
  popl %ebp
  ret





