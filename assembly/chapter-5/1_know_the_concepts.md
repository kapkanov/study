- Describe the lifecycle of a file descriptor.

It's created via system call to open a file by filename. OS provides it to the process. Then other operations could be performed with the file descriptor, like read, write operations, etc. After that the original processed working with file make a system call to the OS to close this file descriptor, verifying that all operations have been completed and then making the value of the closed file descriptor useless.


- What are the standard file descriptors and what are they used for?

0 - STDIN, standard input from the keyboard, other devices or other processes. It's an abstraction from the OS to handle standard way for providing data to the process.
1 - STDOUT, standard output. Working in the terminal (tty device) most of the time this data is directed to the screen.
2 - STDERR, standard error. It's the file descriptor to handle stream of error data. Most of the time in the terminal data for this file descriptor redirected to the screen.


- What is a buffer?

It's a continuous block of memory reserved for the process. The buffer can be accessed via the label prepending it's definition.


- What is the difference between `.data` section and the `.bss` section?

It's not included into the binary itself like in the `.section .data`. 


- What are the system calls related to reading and writing files?

Open, read, write, close.
