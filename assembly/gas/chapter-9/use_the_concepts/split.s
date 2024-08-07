.include "malloc.s"

.section .data
ptr:
  .long 0

.section .text
.globl _start
_start:
  pushl $128
  call  allocate
  movl  %eax,      ptr

  pushl ptr
  call  deallocate

  pushl $64
  call  allocate

  movl  $1,        %eax
  movl  $0,        %ebx
  int   $0x80
