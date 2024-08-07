### What does it mean if a line in the program starts with the '#' character?

It means this line is commented and assembler will ignore during assembling.


### What is the difference between an assembly language file and an object code file?

Assembly language file contains text consisting of ascii or unicode symbols. Object code file contains binary machine instructions and a symbolic table for linking it later.


### What does the linker do?

It merges object files into a single executable.


### How do you check the result status code of the last program you ran?

`echo $?`


### What is the difference between `movl $1, %eax` and `movl 1, %eax`?

`movl $1, %eax` uses immediate address mode, thus it puts value `1` into the register `%eax`

`movl 1, %eax` uses direct address mode, it puts value contained in memory address `1` to the register `%eax`


### Which register hold the system call number?

`%eax`


### What are indexes used for?

To get a value from a contiguous block of memory constisted of fixed-size elements.


### Why do indexes usually start at 0?

Because sequences of values are referenced by the address of their first element, thus address of the first element plus zero equals to the address of the first element.


### If I issued the command `movl data_items(,%edi,4), %eax` and `data_items` was address `3634` and `%edi` held the value `13`, what address would you be using to move into `%eax`?

```
3686 = 3634 + 13 * 4
          [ 52 ]
```


### List the general-purpose registers

`%eax`, `%ebx`, `%edi`, `%ecx`, `%edx`, `%esi`


### What is the difference between `movl` and `movb`?

`movl` moves long values (4-bytes width). `movb` moves 1-byte width values


### What is flow control?

It is management of an order of the execution of the program, i.e. you can execute part of the program multiple times or skip some parts depending on conditions.


### What does a conditional jump do?

It points program counter on a part of the program provided via operand, depending on the result of a conditional operation took place beforehand.


### What things do you have to plan for when writing a program?

Everything. More specifically: structure of the data, where to store the data, how to retrieve the data, how to operate on the data and store the results of the computations.


### Go through every instruction and list what addressing mode is being used for each operand.


`movl $0, %edi` immediate mode
`movl data_items(,%edi,4), %eax` index mode
`movl %eax, %ebx` register mode
`cmpl $0, %eax` immediate mode
`incl %edi` register mode
`movl data_items(,%edi,4)` index mode
`cmpl %ebx, %eax` register mode
`movl %eax, %ebx` register mode
`movl $1, %eax` immediate mode
`int $0x80` immediate mode
