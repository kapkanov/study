
.include "stack.s"

# Count characters until a null byte
# 1 param - pointer to the buffer
# %eax    - return value; length of the string
# %ebx    - pointer to the buffer
.type strlen,@function
.globl strlen

strlen:
  pushl %ebp
  movl  %esp,          %ebp
  movl  PARAM_1(%ebp), %ebx
  movl  $0,            %eax
strlen_loop:
  cmpb  $0,            (%ebx,%eax,1)
  je    strlen_exit
  incl  %eax
  jmp   strlen_loop
strlen_exit:
  movl  %ebp,          %esp
  popl  %ebp
  ret
