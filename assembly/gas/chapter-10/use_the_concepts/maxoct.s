# Find maximum number of a set of data items

# %edi - index of the data
# %ebx - largest data item found
# %eax - current data item

# data_items - contains the item data. 0 is used to terminate the data

.include "i2soct.s"

.section .bss
.lcomm buf, 16

.section .data
data_items:
.long 3,67,34,222,45,75173,54,33,12,16,0

.section .text
.globl _start
_start:
  movl $0,                  %edi
  movl data_items(,%edi,4), %eax
  movl %eax,                %ebx

start_loop:
  cmpl $0,                  %eax
  je loop_exit
  incl %edi
  movl data_items(,%edi,4), %eax
  cmpl %ebx,                %eax
  jle start_loop
  movl %eax,                %ebx
  jmp start_loop

loop_exit:
  pushl $buf
  pushl %ebx
  call  i2soct
  movl  $buf,               %ecx
  movl  $1,                 %eax # 1 is exit() syscall
  int   $0x80
