.section .data

# It doesn't work as I expected
record:
  .align 16
  .ascii "hola\n\0"
  .align 16
  .ascii "salam\n\0"
  .align 16
  .byte  0


.section .text

.globl _start
_start:
  movl $4,      %eax # NR_WRITE
  movl $1,      %ebx # file descriptor
  movl $record, %ecx # *buf
  movl $16,     %edx # len
  int  $0x80

  movl $4,      %eax # NR_WRITE
  movl $1,      %ebx # file descriptor
  movl $record, %ecx # *buf
  addl $16,     %ecx
  movl $16,     %edx # len
  int  $0x80

  movl $1, %eax # NR_EXIT
  movl $0, %ebx
  int $0x80
