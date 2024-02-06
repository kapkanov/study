# Interrupts macros
.set INT_SYS,   0x80
.set NR_EXIT,   0x1
.set NR_READ,   0x3
.set NR_WRITE,  0x4
.set NR_OPEN,   0x5
.set NR_CLOSE,  0x6


# File macros
.set IN_FFLAGS,     00 # O_RDONLY
.set IN_FMODE,    0644
.set OUT_FFLAGS, 03101 # O_WRONLY(01) | O_TRUNC(01000) | O_APPEND(02000) | O_CREAT(0100)
.set OUT_FMODE,   0644

# Stack macros
.set PARAM_1,      8
.set PARAM_2,     12
.set PARAM_3,     16
.set PARAM_4,     20


.section .data


.set BUFLEN, 4
.section .bss
  .lcomm buf, BUFLEN


.section .text

.globl _start

.set LVAR_1,      -4 # input file descriptor
.set LVAR_2,      -8 # output file descriptor
.set LVAR_3,     -12 # length of the input

_start:
  pushl %ebp
  movl  %esp,       %ebp
  subl  $12,        %esp # for local variables

  # Stack for _start looks like this:
  # ... etc.
  # 12(%ebp) - argv[1], first argument during program call
  # 8(%ebp)  - argv[0], filename of the program
  # 4(%ebp)  - argc, number of arguments
  # (%ebp)   - previous %ebp value, it's been pushed few lines ago

  movl $0,          LVAR_1(%ebp)
  movl $1,          LVAR_2(%ebp)
  cmpl $3,          4(%ebp)
  jl   start_loop

  # Open input file
  pushl $IN_FMODE
  pushl $IN_FFLAGS
  pushl PARAM_2(%ebp)
  call  fopen
  movl  %eax,       LVAR_1(%ebp)
  addl  $12,        %esp

  # Open output file
  pushl $OUT_FMODE
  pushl $OUT_FFLAGS
  pushl PARAM_3(%ebp)
  call  fopen
  movl  %eax,        LVAR_2(%ebp)
  addl  $12,         %esp

start_loop:
  # Read input file
  pushl $BUFLEN
  pushl $buf
  pushl LVAR_1(%ebp)
  call  fread 
  # If 0 bytes have been read from the file,
  # then we've already processed 
  # the whole input file and we should leave
  cmpl  $0,          %eax
  je    start_close
  movl  %eax,        LVAR_3(%ebp)
  addl  $12,         %esp

  # Uppercase characters in buf
  pushl LVAR_3(%ebp)
  pushl $buf
  call  toupper
  addl  $8,          %esp

  # Write to the output file
  pushl LVAR_3(%ebp)
  pushl $buf
  pushl LVAR_2(%ebp)
  call  fwrite
  addl  $12,         %esp

  jmp start_loop

start_close:
  # Close input file
  pushl LVAR_1(%ebp)
  call  fclose
  addl  $4,          %esp

  # Close output file
  pushl LVAR_2(%ebp)
  call  fclose
  addl  $4,          %esp

start_exit:
  movl  %ebp,        %esp
  popl  %ebp
  movl  $NR_EXIT,    %eax
  movl  $0,          %ebx
  int   $INT_SYS


# 2 param - buf length
# 1 param - pointer to the buf
# %eax    - buf length
# %ebx    - pointer to the buf
# %edi    - index
# %cl     - current symbol
.type toupper,@function

.set LOWERCASE_A,   'a'
.set LOWERCASE_Z,   'z'
.set TOUPPER_DELTA, 'A'-'a'

toupper:
  pushl %ebp
  movl  %esp,           %ebp
  movl  PARAM_1(%ebp),  %ebx
  movl  PARAM_2(%ebp),  %eax
  movl  $-1,             %edi

toupper_loop:
  incl  %edi
  cmpl  %eax,           %edi
  jge   fexit
  movb  (%ebx,%edi,1),  %cl
  cmpb  $LOWERCASE_A,   %cl
  jl    toupper_loop
  cmpb  $LOWERCASE_Z,   %cl
  jg    toupper_loop
  addb  $TOUPPER_DELTA, %cl
  movb  %cl,            (%ebx,%edi,1)
  jmp   toupper_loop


# 3 parameter  - mode
# 2 parameter  - flags
# 1 parameter  - pointer to a filename
# %eax         - return value, file descriptor
.type fopen,@function

fopen:
  pushl %ebp
  movl  %esp,            %ebp
  movl  $NR_OPEN,        %eax
  movl  PARAM_1(%ebp),   %ebx
  movl  PARAM_2(%ebp),   %ecx
  movl  PARAM_3(%ebp),   %edx
  int   $INT_SYS
  jmp   fexit


# %eax    - return value, number of bytes read
# 3 param - buf length
# 2 param - pointer to the buf
# 1 param - file descriptor
.type fread,@function

fread:
  pushl %ebp
  movl  %esp,          %ebp
  movl  PARAM_1(%ebp), %ebx
  movl  PARAM_2(%ebp), %ecx
  movl  PARAM_3(%ebp), %edx
  movl  $NR_READ,      %eax
  int   $INT_SYS
  jmp   fexit


# 3 param - length of the buf
# 2 param - pointer to the buf
# 1 param - file descriptor
.type fwrite,@function

fwrite:
  pushl %ebp
  movl  %esp,          %ebp
  movl  PARAM_1(%ebp), %ebx
  movl  PARAM_2(%ebp), %ecx
  movl  PARAM_3(%ebp), %edx
  movl  $NR_WRITE,     %eax
  int   $INT_SYS
  jmp   fexit
 

# 1 parameter - file descriptor
.type fclose,@function

fclose:
  pushl %ebp
  movl  %esp,          %ebp
  movl  PARAM_1(%ebp), %ebx
  movl  $NR_CLOSE,    %eax
  int   $INT_SYS
  jmp   fexit

fexit:
  movl %ebp, %esp
  popl %ebp
  ret

