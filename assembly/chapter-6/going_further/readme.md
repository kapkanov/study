- Rewrite the programs in this chapter to use command-line arguments to specify the filenames.

`./read-records.s`, `./write-records.s`


- Research the `lseek` system call. Rewrite the `add-year` program to open the source file for both reading and writing (use $2 for the read/write mode), and write the modified records back to the same file they were read from.

`./add-year.s`


- Research the various error codes that can be returned by the system calls made in these programs. Pick one to rewrite, and add code that checks `%eax`, for error conditions, and, if one is found, writes a message about it to `STDERR` and exit.

Nah it's tedious.


- Write a program that will add a single record to the file by reading the data from the keyboard. Remember, you will have to make sure that the data has at least one null character at the end, and you need to have a way for the user to indicate they are done typing. Because we have not gotten into characters to numbers conversion, you will not be able to read the age in from the keyboard, so you'll have to have a default age.

`./stdin.s`


- Write a function called `compare-strings` that will compare two strings up to 5 characters. Then write a program that allows the user to enter 5 characters, and have the program return all records whose first name starts with those 5 characters.

`./cmp.s`, `./grep.s`
