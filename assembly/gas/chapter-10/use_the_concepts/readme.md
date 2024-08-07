### Go back to previous programs that returned numeric results through the exit status code, and rewrite them to print out the results instead using our integer to string conversion function.

```
./max.s
as --32 -g -o max.o max.s
ld -melf_i386 -o max.bin max.o
gdb max.bin
```
Then make a breakpoint and run to the `movl $buf, %ecx` line. Inspect address of `buf` via `i r ecx` and print the string at this address `x/sb <address>`.

### Modify the `integer2string` code to return results in octal rather than decimal.

```
./i2soct.s
./maxoct.s
```

### Write a function called `is_negative` that takes a single integer as a parameter and returns 1 if the parameter is negative, and 0 if the parameter is positive.

`./isneg.s`
