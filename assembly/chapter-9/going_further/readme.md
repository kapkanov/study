### Research **garbage collection**. What advantages and disadvantages does this have over the style of memory management used here?

Advantages:
- It can prevent memory leaks, when you allocated memory but forgot to deallocate it.
- Garbage collection can return back memory to the OS, so it can be used by other processes
- It automatically tracks the use of memory regions. So if you've done work with some memory regions, garbage collector can free that memory region implicitly and automatically
- Garbage collector takes into account all objects in your code, so in case of memory region being used by multiple parts of the program or simply there are multiple references to this piece of memory, if one of the references were terminated, garbage collector wouldn't free the memory region, because there are objects that still have reference to this memory region.

Disadvantages:
- It adds overhead. Garbage collector takes both CPU time and memory for execution.
- Garbage collector reduces control over program execution. Generally with garbage collector enabled you do not free memory manually. So you have to rely on it, rather than manipulate what's going to happen during program execution.


### Research **reference counting**. What advantages and disadvantages does this have over the style of memory management used here?

It can provide you a hint about whether it's safe to free the memory region, so you won't eventually break a process by a segmentation fault error. But it adds overhead to update counter every time you work with the memory region adding new or removing old references. Also quiet easy you can find yourself in a situation when you can't just free the memory, because counter is above zero.


### Change the name of the functions to `malloc` and `free`, and build them into a shared library. Use `LD_PRELOAD` to force them to be used as your memory manager instead of the default one. Add some `write` system calls to `STDOUT` to verify that your memory manager is being used insted of the default one.

Nah it's annoying to build 32-bit binary on 64-bit Linux via gcc.
