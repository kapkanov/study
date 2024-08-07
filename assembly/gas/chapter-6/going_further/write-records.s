.include "linux.s"
.include "stack.s"
.include "recdef.s"
.include "recwrite.s"


.section .data

rec1:
  .ascii "Frederick\0"
  .skip RECLEN_FIRSTNAME - 10

  .ascii "Bartlett\0"
  .skip RECLEN_LASTNAME - 9

  .ascii "4242 S Prairie \nTulsa, OK 55555\0"
  .skip RECLEN_ADDRESS - 32

  .long  45


rec2:
  .ascii "Marilyn\0"
  .skip  RECLEN_FIRSTNAME - 8

  .ascii "Taylor\0"
  .skip  RECLEN_LASTNAME - 7

  .ascii "2224 S Johannan St\nChicago, IL 12345\0"
  .skip  RECLEN_ADDRESS - 37

  .long  29


rec3:
  .ascii "Derrick\0"
  .skip  RECLEN_FIRSTNAME - 8

  .ascii "McIntire\0"
  .skip  RECLEN_LASTNAME - 9

  .ascii "500 W Oakland\nSan Diego, CA 54321\0"
  .skip  RECLEN_ADDRESS - 34

  .long  36

.section .text

# LVAR_1 - file descriptor
.set FMODE, FMODE_WRONLY | FMODE_TRUNC | FMODE_CREAT
.globl _start
_start:
  movl  %esp,         %ebp
  subl  $4,           %esp

  # 8(%ebp) - arg 1
  # 4(%ebp) - program filename
  #  (%ebp) - argc
  cmpl  $2,            (%ebp)
  jne   _start_exit

# Open file
  movl $NR_OPEN,      %eax
  movl 8(%ebp),       %ebx
  movl $FMODE,        %ecx
  movl $FPERM,        %edx
  int  $INT_SYS
  movl %eax,          LVAR_1(%ebp)

# Write rec1
  pushl $rec1
  pushl LVAR_1(%ebp)
  call  recwrite
  addl  $8,           %esp
 
# Write rec2
  pushl $rec2
  pushl LVAR_1(%ebp)
  call  recwrite
  addl  $8,           %esp

# Write rec3
  pushl $rec3
  pushl LVAR_1(%ebp)
  call  recwrite
  addl  $8,           %esp

# Close file
  movl  $NR_CLOSE,    %eax
  movl  LVAR_1(%ebp), %ebx
  int   $INT_SYS

_start_exit:
  movl  %ebp,         %esp
  popl  %ebp
  movl  $NR_EXIT,     %eax
  movl  $0,           %ebx
  int   $INT_SYS
