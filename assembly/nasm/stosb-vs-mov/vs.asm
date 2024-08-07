section .bss
buff: resb 1024 * 1024 * 1024
bufflen: equ $ - buff
str: resb 1024
strlen: equ $ - str

section .data
strreps: db " repetitions", 10
strrepslen: equ $ - strreps

strmov: db "mov took "
strmovlen: equ $ - strmov

seconds: db " seconds", 10
secondslen: equ $ - seconds

strstosb: db "stosb took "
strstosblen: equ $ - strstosb

newline: db 10

section .text

; How much times to repeat fill operation
REPS: equ 50

; SET in EAX int
; SET in EBX pointer to the last byte of a buffer
; GET in ECX pointer to the start of a string
; GET in EDX length of the string
int2str:
  push ebx
.loop:
  mov  edx, 0
  mov  ecx, 10
  div  ecx
  push eax
  mov  eax, edx
  add  eax, '0'
  mov  byte [ebx], al
  pop  eax
  cmp  eax, 0
  je   .exit
  dec  ebx
  jmp  .loop
  
.exit:
  mov ecx, ebx
  pop edx
  sub edx, ecx
  inc edx
  ret

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

global _start

; GET in EAX time in epoch
time:
  mov eax, 0xd
  mov ebx, 0
  int 0x80
  ret

timeprint:
  call time
  mov  ebx, str
  add  ebx, strlen
  dec  ebx
  call int2str
  call nprint
  ret

; SET in EAX pointer to a buffer
; SET in EBX length of the buffer
; SET in CL value to fill the buffer
fill_mov:
  mov edx, 0
  dec ebx
.loop:
  mov byte [eax + ebx], cl
  dec ebx
  jnz .loop
  ret

; SET in AL value to fill the buffer
; SET in EDI pointer to the buffer
; SET in ECX number of values to fill
fill_stosb:
  rep stosb
  ret

; SET in EDX label to execute
; SET in ESI times to repeat
repeat:
.again:
  pushad
  call edx
  popad
  dec  esi
  jnz  .again
  ret

_start:
  ; Print number of repetitions on the screen
  mov  eax, REPS
  mov  ebx, buff
  add  ebx, bufflen
  dec  ebx
  call int2str
  call print
  mov  ecx, strreps
  mov  edx, strrepslen
  call print
  ;

  ; Repeat fill operation via mov instruction
  mov  ecx, strmov
  mov  edx, strmovlen
  call print

  call time
  push eax

  mov  eax, buff
  mov  ebx, bufflen
  mov  ecx, 'A'
  mov  edx, fill_mov
  mov  esi, REPS
  call repeat

  call time
  pop  ebx
  sub  eax, ebx
  mov  ebx, buff
  add  ebx, bufflen
  dec  ebx
  call int2str
  call print

  mov  ecx, seconds
  mov  edx, secondslen
  call print
  ;

  ; Repeat fill operation via stosb
  mov  ecx, strstosb
  mov  edx, strstosblen
  call print

  call time
  push eax

  mov  al, 'A'
  mov  edi, buff
  mov  ecx, bufflen
  mov  edx, fill_stosb
  mov  esi, REPS
  call repeat

  call time
  pop  ebx
  sub  eax, ebx
  mov  ebx, buff
  add  ebx, bufflen
  dec  ebx
  call int2str
  call print

  mov  ecx, seconds
  mov  edx, secondslen
  call print
  ;


  ; call timeprint

  ; mov  eax, buff
  ; mov  ebx, bufflen
  ; mov  ecx, 'A'
  ; mov  edx, fill_mov
  ; mov  esi, REPS
  ; call repeat

  ; fill once
  ; mov al, 'A'
  ; mov edi, buff
  ; mov ecx, bufflen
  ; call fill_stosb

  ; mov  al, 'A'
  ; mov  edi, buff
  ; mov  ecx, bufflen
  ; mov  edx, fill_stosb
  ; mov  esi, REPS
  ; call repeat

  ; fill once
  ; mov  eax, buff
  ; mov  ebx, bufflen
  ; mov  ecx, 'A'
  ; call fill_mov

  ; call timeprint


exit:
  mov eax, 1 ; sys_call exit
  mov ebx, 0 ; error_code
  int 0x80
