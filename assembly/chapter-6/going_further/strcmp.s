.include "stack.s"

# Compare strings
# PARAM_1 - pointer to first  string
# PARAM_2 - pointer to second string
# %eax    - return value
#           0 strings are not equal
#           1 strings are     equal
# %edi    - index
.set STRCMPLEN, 5
.globl strcmp
.type strcmp,@function
strcmp:
  pushl %ebp
  movl  %esp,             %ebp
  movl  $0,               %edi
  movl  $0,               %eax

strcmp_loop:
  cmpl  $STRCMPLEN - 1,   %edi
  je    strcmp_maxlen

  movl  PARAM_1(%ebp),    %edx
  movb  (%edx,%edi,1),    %bl
  cmpb  $0,               %bl
  je    strcmp_exit_str1

  movl  PARAM_2(%ebp),    %edx
  movb  (%edx,%edi,1),    %cl
  cmpb  $0,               %cl
  je    strcmp_exit_str2

  incl  %edi
  cmpb  %bl,              %cl
  je    strcmp_loop
  jmp   strcmp_exit

strcmp_maxlen:
  movl  $1,               %eax
  jmp   strcmp_exit

strcmp_exit_str1:
  movl  PARAM_2(%ebp),    %edx
  movb  (%edx,%edi,1),    %cl
  cmpb  %bl,              %cl
  jne   strcmp_exit
  movl  $1,               %eax
  jmp   strcmp_exit

strcmp_exit_str2:
  movl  PARAM_1(%ebp),    %edx
  movb  (%edx,%edi,1),    %bl
  cmpb  %cl,              %bl
  jne   strcmp_exit
  movl  $1,               %eax
  jmp   strcmp_exit

strcmp_exit:
  movl  %ebp, %esp
  popl  %ebp
  ret
