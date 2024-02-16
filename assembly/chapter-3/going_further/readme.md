- Modify the first program to leave off the int instruction line. Assemble, link, and execute the new program. What error mesage do you get? Why do you think this might be?

Because program doesn't terminate, program counter increases to the memory beyond the program.


- So far, we have discussed three approaches to finding the end of the list - using a special number, using the ending address, and using the length count. Which approach do you think is best? Why? Which approach would you use if you knew that the list was sorted? Why?

It depends. 

If length of the data varies, it's better to use terminating number. But we have to ensure that this number is not used in the data.

If we know the length of the data, it's best to use length count, it's quite easy to compare index with length. Using end address is almost the same, but it requires additional steps to convert index to address and then check whether address does not exceed the limit.

If the list is sorted, I would pick length count or ending address, because there is no need for traversing the data.


