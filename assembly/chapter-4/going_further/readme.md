- Do you think it's better fo a system to have a large set of primitives or a small one, assuming that the larger set can be written in terms of the smaller one?

I think it's better to have a small set of primitives, because it better not to overwhelm with functionality.


- The factorial function can be written non-recursively. Do so

`./factorial-non-recursive.s`


- Come up with your own calling convention. Rewrite the programs in this chapter usin it. An example of a different calling convention would be to pass parameters in registers rather than the stack, to pass them in a different order, to return values in other registers or memory locations. Whatever you pick, be consistent and apply it throughout the whole program.

```
Convention:
1. Return value in `%eax`
2. Parameters in order in registers: `%ebx`, `%ecx`, `%edx`
3. Local variables: `%edi`, `%esi`
```


- Can you build a calling convention without using the stack? What limitations might it have?

Obviously it's a size limitation. There are not so many general purpose registers, like around 5 or so, with stack you are potentially not limited at all.


- What test cases should we use in our example program to check to see if it is working properly?

I think `-1, 0, 1, 2, 3` would be enough for the rough check of the functionality. It would be better to check numbers near the limits of the long number.

