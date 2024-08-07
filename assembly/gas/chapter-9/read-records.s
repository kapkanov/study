# Open the file
# Attempt to read a record
# If we are at the end of the file, exit
# Otherwise, count the characters of the first name
# Write the first name to STDOUT
# Write a newline to STDOUT
# Go back to read another record

.include "stack.s"
.include "linux.s"
.include "recdef.s"
.include "recread.s"
.include "strlen.s"
.include "wnewline.s"
.include "malloc.s"

.section .data
fname:
  .ascii "test.dat\0"
record_buffer_ptr:
  .long 0

# LVAR_1 - file descriptor
# LVAR_2 - length of the first name
.section .text
.globl _start
_start:
  movl %esp,          %ebp
  subl $8,            %esp

  call allocate_init

  # Open the file
  movl $NR_OPEN,      %eax
  movl $fname,        %ebx
  # movl $FMODE_RDONLY, %ecx
  movl $0,            %ecx
  movl $FPERM,        %edx
  int  $INT_SYS
  movl %eax,          LVAR_1(%ebp)

_start_loop:
  pushl $RECLEN
  call  allocate
  movl  %eax,         record_buffer_ptr

  # Attempt to read a record
  pushl record_buffer_ptr
  pushl LVAR_1(%ebp)
  call  recread
  addl  $8,           %esp

  # If we are at the end of the file, exit
#  cmpl  $0,           %eax
  cmpl  $RECLEN,      %eax
  jne   _start_exit

  # Otherwise, count the characters of the first name
  movl  record_buffer_ptr,    %eax
  addl  $RECOFFSET_FIRSTNAME, %eax
  pushl %eax
  call  strlen
  movl  %eax,         LVAR_2(%ebp)
  addl  $4,           %esp

  # Write the first name to STDOUT
  movl  $NR_WRITE,    %eax
  movl  $1,           %ebx

  movl  record_buffer_ptr,    %ecx
  addl  $RECOFFSET_FIRSTNAME, %ecx

  movl  LVAR_2(%ebp), %edx
  int   $INT_SYS

  # Write a newline to STDOUT
  pushl $1
  call  wnewline
  addl  $4,           %esp

  pushl record_buffer_ptr
  call  deallocate

  # Go back to read another record
  jmp  _start_loop

_start_exit:
  movl  $NR_EXIT,     %eax
  movl  $0,           %ebx
  int   $INT_SYS
