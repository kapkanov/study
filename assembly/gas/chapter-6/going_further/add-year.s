# Opens an input and output file
# Reads records from the input
# Increments the age
# Write the new record to the output file

.include "stack.s"
.include "linux.s"
.include "recdef.s"
.include "recread.s"
.include "recwrite.s"


.section .data
fname:
  .ascii "test.dat\0"


.section .bss
.lcomm buf, RECLEN


.section .text

# LVAR_1 - file descriptor of a file
.set LVARLEN,  8
.globl _start
_start:
  movl  %esp,          %ebp
  subl  $LVARLEN,      %esp

  # Open file
  movl  $NR_OPEN,      %eax
  movl  $fname,        %ebx
  movl  $FMODE_RDWR,   %ecx
  movl  $FPERM,        %edx
  int   $INT_SYS
  movl  %eax,          LVAR_1(%ebp)

_start_loop:
  # Read a single record
  pushl $buf
  pushl LVAR_1(%ebp)
  call  recread
  addl  $8,            %esp

  # Exit on EOF or error
  cmpl  $RECLEN,       %eax
  jne   _start_exit

  # Increment age
  movl  $buf, %eax # for debug
  incl  buf + RECOFFSET_AGE

  # Return file cursor to the start of the record
  movl  $NR_LSEEK,     %eax
  movl  LVAR_1(%ebp),  %ebx
  movl  $0,            %ecx
  subl  $RECLEN,       %ecx
  movl  $SEEK_CUR,     %edx
  int   $INT_SYS

  # Write updated record back to the file
  pushl $buf
  pushl LVAR_1(%ebp)
  call  recwrite
  addl  $8,            %esp

  # Repeat
  jmp  _start_loop

_start_exit:
  # Close the file
  movl  $NR_CLOSE,    %eax
  movl  LVAR_1(%ebp), %ebx
  int   $INT_SYS

  # Exit program
  movl  $NR_EXIT,     %eax
  movl  $0,           %ebx
  int   $INT_SYS
