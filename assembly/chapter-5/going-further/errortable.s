.section .data

err_1:
  .ascii "salam\0"
err_2:
  .ascii "hola\0"

errcode:
  .long err_1
  .long err_2


.section .text

.globl _start
_start:
  movl $1,      %eax
  movl errcode, %ebx
  movl (%ebx),  %ebx
  int  $0x80
