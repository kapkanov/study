### Modify the memory manager so that it calls `allocate_init` automatically if it hasn't been initialized.

`./malloc.s`


### Modify the memory manager so that if the requested size of memory is smaller than the region chosen, it will break up the region into multiple parts. Be sure to take into account the size of the new header record when you do this.

`./malloc.s`, `./split.s`. I tested in in `gdb`.
`as -g --32 -o split.o split.s`
`ld -melf_i386 -o split.bin split.o`


### Modify one of your programs that uses buffers to use the memory manager to get buffer memory rather than using the `.bss`

Nah I'm good
