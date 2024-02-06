# Find maximum number of a set of data items

# %edi - index of the data
# %ebx - largest data item found
# %eax - current data item

# data_items - contains the item data. 0 is used to terminate the data

.section .data

  data_items:
    .long 3,67,34,222,45,75,54,33,12,16,255

.section .text
  .globl _start
  _start:
    movl $0, %edi
    movl data_items(,%edi,4), %eax
    movl %eax, %ebx
    incl %eax

  start_loop:
    movl data_items(,%edi,4), %eax
    cmpl $255, %eax
    je loop_exit
    incl %edi
    cmpl %ebx, %eax
    jle start_loop
    movl %eax, %ebx
    jmp start_loop

  loop_exit:
    movl $1, %eax # 1 is exit() syscall
    int $0x80
