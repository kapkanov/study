section .bss

section .data
  newline: db 10


section .text

; SET in ECX pointer to the buffer
; SET in EDX length of the buffer
print:
  mov eax, 4 ; sys_write
  mov ebx, 1 ; stdout
  int 0x80
  ret

; SET in ECX pointer to the buffer
; SET in EDX length of the buffer
nprint:
  call print
  mov  ecx, newline
  mov  edx, 1
  call print
  ret

; Print zero terminated string
; SET in ECX pointer to the buffer
zprint:
  pushad
  mov    ebx, ecx    ; save initial address of a string
                     ; to calculate its length
  mov    edi, ecx
  mov    ecx, 0xffff ; max length of the string
  xor    eax, eax    ; character to search, 0
  cld
  repne  scasb
  sub    edi, ebx
  dec    edi
  mov    ecx, ebx
  mov    edx, edi
  call   print
  popad
  ret

; SET in ECX pointer to the buffer
nzprint:
  call zprint
  mov  ecx, newline
  mov  edx, 1
  call print
  ret

global _start

_start:
  nop

  mov   ebp, esp    ; save initial top of the stack.
  xor   eax, eax    ; search for 0 at address.
  mov   ecx, 0xffff ; max number of pointers.
  mov   edi, ebp    ; start searching for 0
  add   edi, 4      ; from start of the args block.
  repne scasb       ; encounter end of block of arguments.
  add   edi, 3      ; move to a start of envs block of pointers.

.loop:
  mov  ecx,         [edi]
  call nzprint
  add  edi,         4
  cmp  dword [edi], 0
  jne  .loop

  nop

exit:
  mov eax, 1 ; sys_call exit
  mov ebx, edi
  ; mov ebx, 0 ; error_code
  int 0x80
