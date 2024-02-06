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

EPERM:        .ascii "Operation not permitted\0"                       #   1
ENOENT:       .ascii "No such file or directory\n\0"                   #   2
EINTR:        .ascii "Interrupted system call\0"                       #   4
ENXIO:        .ascii "No such device or address\0"                     #   6
EBADF:        .ascii "Bad file number\0"                               #   9
EWOULDBLOCK:  .ascii "Operation would block\0"                         #  11
ENOMEM:       .ascii "Out of memory\0"                                 #  12
EACCESS:      .ascii "Permission denied\0"                             #  13
EFAULT:       .ascii "Bad address\0"                                   #  14
EEXIST:       .ascii "File exists\0"                                   #  17
ENODEV:       .ascii "No such device\0"                                #  19
ENOTDIR:      .ascii "Not a directory\0"                               #  20
EISDIR:       .ascii "Is a directory\0"                                #  21
EINVAL:       .ascii "Invalid argument\0"                              #  22
ENFILE:       .ascii "File table overflow\0"                           #  23
EMFILE:       .ascii "Too many open files\0"                           #  24
ETXTBSY:      .ascii "Text file busy\0"                                #  26
EFBIG:        .ascii "File too large\0"                                #  27
ENOSPC:       .ascii "No space left on device\0"                       #  28
EROFS:        .ascii "Read-only file system\0"                         #  30
ENAMETOOLONG: .ascii "File name too long\0"                            #  36
ELOOP:        .ascii "Too many symbolic links encountered\0"           #  40
EOVERFLOW:    .ascii "Value too large for defined data type\0"         #  75
EOPNOTSUPP:   .ascii "Operation not supported on transport endpoint\0" #  95
EDQUOT:       .ascii "Quota exceeded\0"                                # 122

errtable:
  .skip   4 
  .long EPERM,ENOENT
  .skip   4 
  .long EINTR
  .skip   4 
  .long ENXIO
  .skip   8 
  .long EBADF
  .skip   4 
  .long EWOULDBLOCK,ENOMEM,EACCESS,EFAULT
  .skip   8 
  .long EEXIST
  .skip   4 
  .long ENODEV,ENOTDIR,EISDIR,EINVAL,ENFILE,EMFILE
  .skip   4 
  .long ETXTBSY,EFBIG,ENOSPC
  .skip   4 
  .long EROFS
  .skip  20 
  .long ENAMETOOLONG
  .skip  12 
  .long ELOOP
  .skip 136 
  .long EOVERFLOW
  .skip  76 
  .long EOPNOTSUPP
  .skip 104 
  .long EDQUOT


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
  movl  $-1,            %edi

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
  cmpl  $0,              %eax
  jg    fopen_exit
  call  perror
  movl  %eax,            %ebx
  imull $-1,             %ebx
  movl  $NR_EXIT,        %eax
  int   $INT_SYS
fopen_exit:
  jmp fexit


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
  cmpl  $0,            %eax
  jg    fread_exit
  call  perror
fread_exit:
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

# Prints error message to STDOUT
# %eax - error code
# %ebx - offset in errtable
# %ecx - pointer to the error message
# %edi - length of the error message
.type perror,@function
perror:
  movl  $-4,            %ebx
  imull %eax,           %ebx
  movl  errtable(%ebx), %ecx
  movl  $0,             %edi
perror_loop:
  movb  (%ecx,%edi,1),  %bl
  cmpb  $0,             %bl
  je    perror_print
  incl  %edi
  jmp   perror_loop
perror_print:
  pushl %edi
  pushl %ecx
  pushl $1
  call  fwrite
  addl  $12,            %esp
  ret
