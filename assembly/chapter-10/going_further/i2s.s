# %ecx - count of characters processed
# %eax - current value
# %edi - base (10)

.section .data
alphabet:
  .ascii "abcdefghijklmnopqrstuvwxyz\0"

.section .text
.equ ST_VALUE,   8
.equ ST_BUFFER, 12

.globl i2s
.type i2s, @function
i2s:
  pushl %ebp
  movl  %esp,           %ebp

  movl  $0,             %ecx
  movl  ST_VALUE(%ebp), %eax
  movl  $16,            %edi

conversion_loop:
  # Division is performed
  # on combined %edx:%eax register
  movl  $0,             %edx

  # Divide %edx:%eax, store
  # quotient in %eax, remainder in %edx
  divl  %edi

  cmpl  $9,             %edx
  jle   conversion_loop_digit

  subl  $10,            %edx
  pushl alphabet(%edx)
  jmp   conversion_loop_check

conversion_loop_digit:
  addl  $'0',           %edx
  pushl %edx

conversion_loop_check:
  incl  %ecx

  cmpl  $0,             %eax
  je    end_conversion_loop

  jmp   conversion_loop

end_conversion_loop:
  movl ST_BUFFER(%ebp), %edx

copy_reversing_loop:
  popl  %eax
  movb  %al,            (%edx)
  decl  %ecx
  incl  %edx

  cmpl  $0,             %ecx
  je    end_copy_reversing_loop

  jmp   copy_reversing_loop

end_copy_reversing_loop:
  movb  $0,             (%edx)
  movl  %ebp,           %esp
  popl  %ebp
  ret

