- What is a record?

It's a structured data. This way we have some rules to store our data: words, strings, numbers, etc.


- What is the advantage of fixed-length records over variable-length records?

This way we can easily navigate through the data: get a specific record or even a specific value in a specific record. We can simply calculate the address of this data. Dealing with variable-length records we have to go through whole file to find the place we are looking for.

Also it's harder to modify variable-length records: if we want to add few symbols to the field of the record, we have to modify the file from this point to the end. On the other hand in most cases we have reserved space working with fixed-size records.


- How do you include constants in multiple assembly source files?

With `.include` directive


- Why might you want to split up a project into multiple source files?

In some cases it's supposed to be easier to deal with less lines in a single source file. It's not an easy trick to perform. This way we logically split our programs, to abstract from inner implementation of some functionality.


- What does the instruction `incl record_buffer + RECORD_AGE` do? What addressing mode is it iusing? How many operands does the `incl` instructions have in this case? Which parts are being handled by the assembler and which parts are being handled when the program is run?

`incl record_buffer + RECORD_AGE` uses direct addressing mode, it increments the value at address `record_buffer + RECORD_AGE`. The instruction has one operand - address of the value. Assembler calculates the "address" of the value, so in binary file an operand is an actual value. When program is being run, OS has to handle this "address" to translate it into a real memory address, because memory allocation for the processes is a dynamic process and an assembler doesn't know beforehand which block of memory would be provided for the process.
