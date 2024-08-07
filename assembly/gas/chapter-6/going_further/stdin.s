.include "linux.s"
.include "stack.s"
.include "recdef.s"
.include "recwrite.s"


.section .data

.set PROMPTLEN, 14
prompt:
  .ascii "Type fields\n\0\0"
firstname:
  .ascii "  Firstname: \0"
lastname:
  .ascii "   Lastname: \0"
address:
  .ascii "    Address: \0"


.section .bss
.lcomm buf, RECLEN


# rec3:
#   .ascii "Derrick\0"
#   .skip  RECLEN_FIRSTNAME - 8
# 
#   .ascii "McIntire\0"
#   .skip  RECLEN_LASTNAME - 9
# 
#   .ascii "500 W Oakland\nSan Diego, CA 54321\0"
#   .skip  RECLEN_ADDRESS - 34
# 
#   .long  36

.section .text

# LVAR_1 - file descriptor
.set FMODE, FMODE_WRONLY | FMODE_TRUNC | FMODE_CREAT
.globl _start
_start:
  movl  %esp,                     %ebp
  subl  $4,                       %esp

  # 8(%ebp) - arg 1
  # 4(%ebp) - program filename
  #  (%ebp) - argc
  cmpl  $2,                       (%ebp)
  jne   _start_exit

# Open file
  movl $NR_OPEN,                  %eax
  movl 8(%ebp),                   %ebx
  movl $FMODE,                    %ecx
  movl $FPERM,                    %edx
  int  $INT_SYS
  movl %eax,                      LVAR_1(%ebp)

  # Print prompt message
  movl $NR_WRITE,                 %eax
  movl $1,                        %ebx
  movl $prompt,                   %ecx
  movl $PROMPTLEN,                %edx
  int  $INT_SYS

  # Read firstname from stdin
  movl $NR_WRITE,                 %eax
  movl $1,                        %ebx
  movl $firstname,                %ecx
  movl $PROMPTLEN,                %edx
  int  $INT_SYS

  movl $NR_READ,                   %eax
  movl $0,                         %ebx
  movl $RECOFFSET_FIRSTNAME + buf, %ecx
  movl $RECLEN_FIRSTNAME,          %edx
  int  $INT_SYS

  # Read lastname from stdin
  movl $NR_WRITE,                 %eax
  movl $1,                        %ebx
  movl $lastname,                 %ecx
  movl $PROMPTLEN,                %edx
  int  $INT_SYS

  movl $NR_READ,                  %eax
  movl $0,                        %ebx
  movl $buf + RECOFFSET_LASTNAME, %ecx
  movl $RECLEN_LASTNAME,          %edx
  int  $INT_SYS

  # Read address from stdin
  movl $NR_WRITE,                 %eax
  movl $1,                        %ebx
  movl $address,                  %ecx
  movl $PROMPTLEN,                %edx
  int  $INT_SYS

  movl $NR_READ,                  %eax
  movl $0,                        %ebx
  movl $buf + RECOFFSET_ADDRESS,  %ecx
  movl $RECLEN_ADDRESS,           %edx
  int  $INT_SYS

  # Write default age to buffer
  movl $21,                       buf + RECOFFSET_AGE

# Write rec3
  pushl $buf
  pushl LVAR_1(%ebp)
  call  recwrite
  addl  $8,                       %esp

# Close file
  movl  $NR_CLOSE,                %eax
  movl  LVAR_1(%ebp),             %ebx
  int   $INT_SYS

_start_exit:
  movl  %ebp,                     %esp
  popl  %ebp
  movl  $NR_EXIT,                 %eax
  movl  $0,                       %ebx
  int   $INT_SYS
