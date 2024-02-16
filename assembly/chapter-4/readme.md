- What are primitives?

It's a basic functions provided by operatins system or software drivers to perform simplest operations. I.e. for gui applications primitives could be functions to draw a line or a dot on the screen


- What are calling conventions?

It's an agreement between programmers about how to store functions' parameters and provide return values.


- What is the stack?

It's a limited space of memory for the running process provided by operating system. Values here are stacked on each other, thus we can push a value on top, and pop (remove, get back) from the top of the stack.


- How to `pushl` and `popl` affect the stack? What special-purpose register do they affect?

`pushl` adds a value to the stack and pushes the top of the stack, so it points to the pushed value.

`popl` gets the value from the top of the stack, puts it into the provided register and decreases the top of the stack, it invalidates the top value, deletes it in a way.


- What are local variables and what are they used for?

Local variables are the variables that exist inside a function. It means that after the function is returned, these values are removed. They are used for storing variables necessary for the function and for calling other functions.


- Why are local variables so necessary in recursive functions?

Because they allow to isolate local variables between function calls.


- What are `%ebp` and `%esp` used for?

`%ebp` is a base pointer register. It points to the location of memory where previous `%ebp` is stored in the stack (previous `%ebp` is the value of `%ebp` register of function that called currently executing function). So the return address to the parent function (that called currently executed function) is located at `4(%ebp)` and parameters are located at `k(%ebp), k = 4*N + 4`, where `N` is the order number of a parameter. And local variables are located at `k(%ebp), k = -4*M`, where `M` is the order number of a local variable.

`%esp` is a pointer to the top of the stack.


- What is a stack frame?

Stack frame consists of the all stack variables used in a function. It's a parameters, local variables and return address.

