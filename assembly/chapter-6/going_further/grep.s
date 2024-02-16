# There is a problem:
#
#   If a user enters exactly 5 characters,
#   there are also a newline character typed,
#   which is usually redirected back to the 
#   shell.
#
#   If a user types more than 5 characters,
#   all exceeding characters are then
#   redirected to the shell as typed input
#   commands.
#
#   It can be resolved by reading all
#   characters from STDIN into some
#   black hole memory location.

.include "stack.s"
.include "linux.s"
.include "recdef.s"
.include "recread.s"
.include "strlen.s"
.include "wnewline.s"
.include "strcmp.s"


.section .bss
.lcomm buf,   RECLEN
.comm  inbuf, STRCMPLEN


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

  # Get string from STDIN
  movl  $NR_READ,                   %eax
  movl  $0,                         %ebx
  movl  $inbuf,                     %ecx
  movl  $STRCMPLEN,                 %edx
  int   $INT_SYS

_start_loop:
  # Attempt to read a record
  pushl $buf
  pushl LVAR_1(%ebp)
  call  recread
  addl  $8,                         %esp

  # If we are at the end of the file, exit
  cmpl  $RECLEN,                    %eax
  jne   _start_exit

  # Otherwise, count the characters of the first name
  pushl $buf + RECOFFSET_FIRSTNAME
  call  strlen
  movl  %eax,                       LVAR_2(%ebp)
  addl  $4,                         %esp

  # Compare firstname and string from STDIN
  pushl $inbuf
  pushl $buf + RECOFFSET_FIRSTNAME
  call  strcmp
  addl  $8,                         %esp
  cmpl  $0,                         %eax
  je    _start_loop

  # Write the first name to STDOUT
  movl  $NR_WRITE,                  %eax
  movl  $1,                         %ebx
  movl  $buf + RECOFFSET_FIRSTNAME, %ecx
  movl  LVAR_2(%ebp),               %edx
  int   $INT_SYS

  # Write a newline to STDOUT
  pushl $1
  call  wnewline
  addl  $4,                         %esp

  # Go back to read another record
  jmp  _start_loop

_start_exit:
  movl  $NR_EXIT,     %eax
  movl  $0,           %ebx
  int   $INT_SYS
