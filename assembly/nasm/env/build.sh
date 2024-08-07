nasm -g -f elf env.asm
ld -melf_i386 -o env.bin env.o
