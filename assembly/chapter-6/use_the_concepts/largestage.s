.include "stack.s"
.include "linux.s"
.include "recdef.s"
.include "recread.s"
.include "wnewline.s"

.section .data
fname:
  .ascii "test.dat\0"

.section .bss
.lcomm buf, RECLEN

# LVAR_1 - file descriptor
# LVAR_2 - largest age
.section .text
.globl _start
_start:
  movl %esp,          %ebp
  subl $8,            %esp

  # Open the file
  movl $NR_OPEN,      %eax
  movl $fname,        %ebx
  movl $FMODE_RDONLY, %ecx
  movl $FPERM,        %edx
  int  $INT_SYS
  movl %eax,          LVAR_1(%ebp)

  movl $0,            LVAR_2(%ebp)
_start_loop:
  # Attempt to read a record
  pushl $buf
  pushl LVAR_1(%ebp)
  call  recread
  addl  $8,           %esp

  # If we are at the end of the file, exit
  cmpl  $RECLEN,      %eax
  jne   _start_exit

  movl  buf + RECOFFSET_AGE, %ecx
  cmpl  %ecx,                LVAR_2(%ebp)
  jge   _start_loop

  movl  %ecx,                LVAR_2(%ebp)
  jmp  _start_loop

_start_exit:
  movl  $NR_EXIT,     %eax
  movl  LVAR_2(%ebp), %ebx
  int   $INT_SYS
