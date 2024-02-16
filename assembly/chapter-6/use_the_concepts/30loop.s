.include "stack.s"
.include "linux.s"
.include "recdef.s"
.include "recwrite.s"


.section .data

fname:
  .ascii "30test.dat\0"

record:
  .ascii "Frederick\0"
  .skip  RECLEN_FIRSTNAME - 10

  .ascii "Bartlett\0"
  .skip  RECLEN_LASTNAME - 9

  .ascii "The Legend of Zelda\0"
  .skip  RECLEN_FAVGAME - 20

  .ascii "4242 S Prairie \nTulsa, OK 55555\0"
  .skip  RECLEN_ADDRESS - 32

  .long  45


.section .text

# LVAR_1 - file descriptor
.set FMODE, FMODE_WRONLY | FMODE_TRUNC | FMODE_CREAT
.globl _start
_start:
  pushl %ebp
  movl  %esp,         %ebp
  subl  $4,           %esp

# Open file
  movl $NR_OPEN,      %eax
  movl $fname,        %ebx
  movl $FMODE,        %ecx
  movl $FPERM,        %edx
  int  $INT_SYS
  movl %eax,          LVAR_1(%ebp)

  movl  $0,           %edi
  pushl $record
  pushl LVAR_1(%ebp)
_start_loop:
  cmpl  $30,          %edi
  je    _start_exit
  incl  %edi
  call  recwrite
  jmp   _start_loop

_start_exit:
  addl  $8,           %esp

# Close file
  movl  $NR_CLOSE,    %eax
  movl  LVAR_1(%ebp), %ebx
  int   $INT_SYS

# Exit
  movl  %ebp,         %esp
  popl  %ebp
  movl  $NR_EXIT,     %eax
  movl  $0,           %ebx
  int   $INT_SYS
