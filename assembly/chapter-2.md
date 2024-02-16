[2002 2003 2004 2005]
[2006 2007 2008 2009]
[2010 2011 2012 2013]
[2014 2015 2016 2017]

- Describe the fetch-execute cycle

Program counter is set to read code at specific point in memory.

After the code pointed by program counter is read, it is being decoded. It means decoder has to determine type of the operation, prerequisites and who will be actually executing it.

Then decoded instruction is scheduled onto specific part to be executed, whether it's arithmetic and logic unit, float point unit or something else. Also it may be pipelined


- What is a register? How would computation be more difficult without registers?

Register is a part of CPU dice that's able to store binary numbers of some lengths. Typical length of the register is called a word length.

Without registers CPU would have to work with main memory directly all the time: to store results of an operations, to store addresses of pointers, etc. It would be harder in a sense of time: memory access time is much bigger than register access time.


- How big are the registers on the machines we will be using?

4 bytes word, 32 bits


- How does a computer know how to interpret a given byte or set of bytes of memory?

It doesn't know. A programmers have to choose appropriate recievers for a specific data types, whether it's a driver or a hardware


- What are the addressing modes and what are they used for?

* Immediate mode
* Register addressing mode
* Direct addressing mode
* Indexed addressing mode
* Indirect addressing mode

They are used to abstract from the actual layout of the main memory. Thus we do not need to be aware of the value and purpose of every byte in the memory, we can work in a somehow isolated memory area and easily adopt our code to work there by setting memory addresses in registers and in memory, instead of recalculating every memory address in our programs.


- What does the instruction pointer do?

It points to the next instruction to be fetched for execution.


- What are the minimum number of addressing modes needed for computation?

2
* Immediate mode.         To perform arithmetic and logic operations
* Direct addressing mode. To be able to load data from the memory


- Why include addressing modes that aren't strictly needed?

Because there are different situations in life, different tasks. Some modes are strictly needed, others are convenient for specific types of tasks.


- Research and then describe how pipelining (or one of the other complicationg factors) affects the fetch-execute cycle.

Pipelining divide cycle into simple pieces, thus instead of 1 instruction per cycle we can execute 2, 4, 8 or even more (it depends on the depth of the pipeline). But to complete a single operation it would take pipeline depth of cycles.


- Research and then describe the tradeoffs between fixed-length instructions and variable-length instructions.

With fixed-length instructions it's much easier to prefetch instructions in advance, navigate through code base. But the code density is static. With variable instruction length instruction density is higher: simple instructions take less space, complex instructions have more space for useful operations.

