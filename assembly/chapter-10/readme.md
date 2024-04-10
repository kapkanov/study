### Convert the decimal number 5294 to binary.

| operation | quotient | remainder |
|-----------|----------|-----------|
| 5294 / 2  | 2647     | 0         |
| 2647 / 2  | 1323     | 1         |
| 1323 / 2  |  661     | 1         |
|  661 / 2  |  330     | 1         |
|  330 / 2  |  165     | 0         |
|  165 / 2  |   82     | 1         |
|   82 / 2  |   41     | 0         |
|   41 / 2  |   20     | 1         |
|   20 / 2  |   10     | 0         |
|   10 / 2  |    5     | 0         |
|    5 / 2  |    2     | 1         |
|    2 / 2  |    1     | 0         |
|    1 / 2  |    0     | 1         |

Answer: `1010010101110`


### What number does `0x0234aeff` represent? Specify in binary, octal and decimal.

It's a 32-bit word.

- Binary

```
0x02 = 0b 0000 0010
0x34 = 0b 0011 0100
0xae = 0b 1010 1110
0xff = 0b 1111 1111

0x0234aeff = 0b 0000 0010 0011 0100 1010 1110 1111 1111
0x0234aeff = 0b10001101001010111011111111
```

- Octal

### Add the binary numbers `101110011` and `101011`.

```
00 000 010 001 101 001 010 111 011 111 111
 0   0   2   1   5   1  2    7   3   7   7

0b0215127377
```

### Multiply the binary numbers `1100` `1010110`.

```
    1010110
   *   1100
  1010110
 1010110
10000001000
```

### Convert the results of the previous two problems into decimal.

```
0b110011110 = 2^1 + 2^2 + 2^3 + 2^4 + 2^7 + 2^8 =
            = 2 + 4 + 8 + 16 + 128 + 256        =
            = 10 + 20 + 128 + 256               =
            = 30 + 128 + 256                    =
            = 158 + 256                         =
            = 414
```

```
0b10000001000 = 2^3 + 2^10 = 8 + 1024 = 1032
```

### Describe how `AND`, `OR`, `NOT`, and `XOR` work.

- `AND` takes two inputs, produces single output. It results 1 only and only if both of the inputs equal to 1, otherwise result is 0.
- `OR` takes two inputs, produces single output. It results 1 if one of the inputs is equal to 1. If both inputs are 0, the output is 0.
- `NOT` takes one input, produces one output. It reverses the input. Thus 0 input results in 1 output and vice versa in other case.
- `XOR` takes two inputs and producec one output. It outputs 1 if both inputs are different (one of them is 0, and the other is 1), otherwise result is 0.

### What is masking for?

Mask is used to determine the value of the specific bit of the input. Meaning of the specific bit is to be determined by the programmer, in general it preserves state. Masking different bits, we can check wheter appropirate bits are set and handle it accordingly.

### What number would you use for the flags of the `open` system call if you wanted to open the file for writing, and create the file if it doesn't exist?

`O_WRONLY`, `O_CREAT`. Finding numbers is cumbersome.

### How would you represent `-55` in a thirty-two bit register?

1. `NOT` the number.
2. Add 1 to it

```
    55     =                               0b11 0111
NOT 55     = 1111 1111 1111 1111 1111 1111 1100 1000
NOT 55 + 1 = 1111 1111 1111 1111 1111 1111 1100 1001
```

### Sign-extend the previous quantity into a 64-bit register.

```
NOT 55 + 1 = 11111 1111 1111 1111 1111 1111 1111 1111 111 1111 1111 1111 1111 1111 1100 1001
```

### Describe the difference between little-endian and big-endian storage of words in memory.

Byte is a least addressable chunk of memory. But there are registers that can hold more than one byte. Thus writing (or reading) this value can be achieved in two ways: write (read) from the most significant to the least significant part (big-endian), or in reverse (little-endian).
