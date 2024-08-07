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

.section .data
fname:
  .ascii "test.dat\0"

.section .bss
.lcomm buf, RECLEN

# LVAR_1 - file descriptor
# LVAR_2 - length of the first name
.section .text
.globl _start
_start:
  movl %esp,          %ebp
  subl $8,            %esp

# 8(%ebp) - arg 1
# 4(%ebp) - program filename
#  (%ebp) - argc
  cmpl $2,            (%ebp)
  jne _start_exit

  # Open the file
  movl $NR_OPEN,      %eax
  movl 8(%ebp),       %ebx
  movl $FMODE_RDONLY, %ecx
  movl $FPERM,        %edx
  int  $INT_SYS
  movl %eax,          LVAR_1(%ebp)

_start_loop:
  # Attempt to read a record
  pushl $buf
  pushl LVAR_1(%ebp)
  call  recread
  addl  $8,           %esp

  # If we are at the end of the file, exit
  cmpl  $RECLEN,      %eax
  jne   _start_exit

  # Otherwise, count the characters of the first name
  pushl $buf + RECOFFSET_FIRSTNAME
  call  strlen
  movl  %eax,         LVAR_2(%ebp)
  addl  $4,           %esp

  # Write the first name to STDOUT
  movl  $NR_WRITE,    %eax
  movl  $1,           %ebx
  movl  $buf + RECOFFSET_FIRSTNAME, %ecx
  movl  LVAR_2(%ebp), %edx
  int   $INT_SYS

  # Write a newline to STDOUT
  pushl $1
  call  wnewline
  addl  $4,           %esp

  # Go back to read another record
  jmp  _start_loop

_start_exit:
  movl  $NR_EXIT,     %eax
  movl  $0,           %ebx
  int   $INT_SYS
