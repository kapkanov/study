- Write a function called `square` which receives one argument and returns the square of that argument.

`./square.s`


- Convert the maximum program given in the Section called Finding a Maximum Value in Chapter 3 so that it is a function which takes a pointer to several values and returns their maximum. Write a program that calls maximum with 3 different lists, and returns the result of the last one as the program's exit status code.

`./max.s`


- Explain the problems that would arise without a standard calling convention.

Without standard calling convention arguments in the caller won't match the parameters in a  callee, so the result of work of the called function is unexpected. We can solve it by checking every single function, but it would be tedious and error-prone.
