### How to assemble and link source code here

`as --32 -I ../chapter-6/ -o read-records.o read-records.s`
`ld -melf_i386 -o read-records.bin read-records.o`

### Describe the layout of memory when a Linux program strats.

`0x0b...`-ish is first accessible memory. There are code and data section. It grows up till the system break point (last accessible memory address). After the break lies inaccessible region of memory. After this region there is a stack. It starts from `0xbfffffff` and grows downwards.

The region between data section and stack is inaccessible because there are virtual addresses that not being mapped to the physical ones, whether it's a physical memory or a disk block.

Stack looks like this:
- Environment variables
- Arguments
- Filename of the program
- Number of arguments (`argc`) <- top of the stack (`%esp`)


### What is the heap?

~~It's a memory that proccess acquires by asking the OS to provide it.~~

It's a pool of memory used by a memory managers. Memory managers asks OS for the memory and keep track of it.


### What is the current break?

It's the last accessible address for the process for now.


### Which direction does the stack grow in?

Downwards.


### Which direction does the heap grow in?

Upwards.


### What happens when you access unmapped memory?

Segmentation fault error, then usually process terminates.


### How does the operation system prevent processes from writing over each other's memory?

OS provides virtual memory for the processes, so they cannot directly work with a physical memory of other processes.


### Describe the process that occurs if a piece of memory you are using is currently residing on disk?

If there are enough free memory for the piece, OS direclty loads it into the memory. If there are not enough memory, OS frees the memory by moving some parts of memory to the disk and then loads the piece into the recently freed space.


### Why do you need an allocator?

To increase efficiency of operations working with memory. To keep track of how much memory is used, to be able to reuse it on the fly, etc.
