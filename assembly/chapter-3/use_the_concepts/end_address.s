# Find maximum number of a set of data items

# %edi - index of the data
# %ebx - largest data item found
# %eax - current data item

# data_items - contains the item data. 0 is used to terminate the data

.section .data

  data_items:
    .long 3,67,34,222,251,0,54,33,12,16

.section .text
  .globl _start
  _start:
    movl $data_items, %esi
    movl %esi,        %edi
    addl $40,         %esi
    movl (%edi),      %eax
    movl %eax,        %ebx
    addl $4,          %edi

  start_loop:
    cmpl %esi,        %edi
    jg   loop_exit
    movl (%edi),      %eax
    addl $4,          %edi
    cmpl %ebx,        %eax
    jle  start_loop
    movl %eax,        %ebx
    jmp  start_loop

  loop_exit:
    movl $1, %eax # 1 is exit() syscall
    int $0x80
