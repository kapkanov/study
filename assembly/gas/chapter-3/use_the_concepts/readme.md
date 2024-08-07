### Modify the first program to return the value 3

`./return3.s`


### Modify the `maximum` program to find the minimum instead

`./min.s`


###  Modify the `maximum` program to use the number 255 to end the list rather than the number 0

`./end_255.s`


### Modify the `maximum` program to use an ending address rather than the number 0 to know then to stop.

`./end_address.s`


### Modify the `maximum` program to use a length count rather than the number 0 to know when to stop

`./end_len.s`

### What would the instruction `movl _start, %eax` do? Be specific, based on your knowledge of both addressing modes and the meaning of `_start`. How would this differ from the instruction `movl $_start, %eax`?

`movl _start, %eax` puts 4-byte value from memory at address `_start` to the register `%eax`. Address `_start` equals to the address of the first instruction following the label. So operation code of `movl $0, %edi` would be put into the register `%eax`. Probably 4 bytes is not enought for this operations, so `%eax` would get only part of this instruction.

`movl $_start, %eax` puts the address of `_start` to the register `%eax`. So the register `%eax` would get the address of `movl $0, %edi` operation, because it's the first operation following the label `_start`.
