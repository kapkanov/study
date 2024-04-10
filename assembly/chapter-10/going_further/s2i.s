.section .text
# %eax - result
# %ebx - current value
# %ecx - index
# %esi - buf address
.globl s2i
.type  s2i, @function
s2i:
  pushl %ebp
  movl  $0,            %eax
  movl  8(%esp),       %esi
  movl  $0,            %ecx
  movl  $0,            %ebx
  movb  (%esi),        %bl
  movl  $0,            %edx
  movl  $10,           %ebp

s2i_loop:
  cmpb  $0,            %bl
  je    s2i_exit

  mull  %ebp
  subb  $'0',          %bl
  addl  %ebx,          %eax

  incl  %ecx
  movb  (%esi,%ecx,1), %bl

  jmp   s2i_loop

s2i_exit:
  popl  %ebp
  ret

.section .data
buf:
  .ascii "74894729\0"

.section .text
.globl _start
_start:
  pushl $buf
  call s2i
  movl  $buf, %ecx

  movl $0, %ebx
  movl $1, %eax
  int  $0x80
