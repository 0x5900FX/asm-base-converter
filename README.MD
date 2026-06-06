x86-64 Assembly Base Converter
A simple command-line program written in x86-64 Assembly (GAS/Intel Syntax) that takes a user-inputted decimal string, converts it to an integer, and then outputs it in Decimal, Binary, and Hexadecimal.

This project was built as a learning exercise to understand how high-level languages handle ASCII-to-Integer (atoi) and Integer-to-ASCII (itoa) conversions under the hood, without relying on C standard library functions.

```
How it works

Input: Uses sys_read to take a string from the user.

String to Integer (ston): Parses the ASCII string character by character, subtracts '0' (0x30) to get the numerical value, and multiplies by 10 to shift digits left.

Integer to String: Uses the div instruction to divide the number by a base (10, 2, or 16). The remainder becomes the rightmost digit. This repeats until the quotient is 0.

Hex Handling: If the remainder for a hex digit is > 9, it adds 'A' - 10 to convert values 10-15 into ASCII 'A'-'F'.

Output: Builds the string backwards in a buffer (to account for how div extracts digits) and prints using sys_write.


Prerequisites
- Linux (x86-64)
- GNU Assembler (GAS)
- GCC (for linking, as the program uses a main label)


How to Build and Run

Clone the repository:

git clone https://github.com/0x5900FX/asm-base-converter.git cd asm-base-converter

Assemble and link:

bash

gcc -nostdlib -o converter converter.s


Run the program:
bash
```

./converter
Example Output

text

Hello user. Enter no from 1-225

42

42

101010

2A


Lessons Learned
- How to properly null-terminate strings after using sys_read.
- How to use the div instruction and handle the rax (quotient) and rdx (remainder) registers.
- ABI Calling Conventions: The importance of saving callee-saved registers like rbx using push and pop.
- Memory manipulation: Building strings from right-to-left in a buffer.


