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
fnamein:
  .ascii "test.dat\0"
fnameout:
  .ascii "testout.dat\0"


.section .bss
.lcomm buf, RECLEN


.section .text

.globl _start
# LVAR_1 - file descriptor of input file
# LVAR_2 - file descriptor of output file
.set LVARLEN,  8
.set FMODEOUT, FMODE_WRONLY | FMODE_TRUNC | FMODE_CREAT
_start:
  movl  %esp,          %ebp
  subl  $LVARLEN,      %esp

  # Open input file
  movl  $NR_OPEN,      %eax
  movl  $fnamein,      %ebx
  movl  $FMODE_RDONLY, %ecx
  movl  $FPERM,        %edx
  int   $INT_SYS
  movl  %eax,          LVAR_1(%ebp)

  # Open output file
  movl  $NR_OPEN,      %eax
  movl  $fnameout,     %ebx
  movl  $FMODEOUT,     %ecx
  movl  $FPERM,        %edx
  int   $INT_SYS
  movl  %eax,          LVAR_2(%ebp)

_start_loop:
  # Read record from the input
  pushl $buf
  pushl LVAR_1(%ebp)
  call  recread
  addl  $8,            %esp

  # Exit on EOF or error
  cmpl  $RECLEN,       %eax
  jne   _start_exit

  # Increment age
  incl  buf + RECOFFSET_AGE

  # Write the new record to the output file
  pushl $buf
  pushl LVAR_2(%ebp)
  call  recwrite
  addl  $8,           %esp

  # Repeat
  jmp  _start_loop

_start_exit:
  # Close input file
  movl  $NR_CLOSE,    %eax
  movl  LVAR_1(%ebp), %ebx
  int   $INT_SYS

  # Close output file
  movl  $NR_CLOSE,    %eax
  movl  LVAR_2(%ebp), %ebx
  int   $INT_SYS

  # Exit program
  movl  $NR_EXIT,     %eax
  movl  $0,           %ebx
  int   $INT_SYS
