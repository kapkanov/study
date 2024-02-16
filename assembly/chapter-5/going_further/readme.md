- What difference does the size of the buffer make?

We can load more data there, thus reduce the amount of syscalls to get the data and send it after processing. But it has a price, we take a memory from the system, thus other processes would be more restricted in such a circumstances.


- What error results can be returned by each of these system calls?

It's written inside manual pages. `man 2 open` for example. Check whole list via `man 2 syscalls`


- Make the program able to either operate on command-line arguments or use `STDIN` or `STDOUT` based on the number of command-line arguments specified by `ARGC`.

`./args_or_std.s`


- Modify the program so that it checks the result of each system call, and prints out an error message to `STDOUT` when it occurs.

`./errcheck.s`
