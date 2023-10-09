#Author: Ashley Chan
#Date: 09/25/2023
#Program Name: Assignment 02 - Array Management System

#!/bin/bash

rm -f *.o
rm -f *.out

echo "Assemble the module manage.asm"
nasm -f elf64 -l manage.lis -o manage.o manage.asm

echo "Assemble the module input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the module output_array.asm"
nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm

echo "Assemble the module sum_array.asm"
nasm -f elf64 -l sum_array.lis -o sum_array.o sum_array.asm

echo "Compile the C module main.c"
gcc -c -m64 -Wall -o main.o main.c -fno-pie -no-pie -std=c17

echo "Link all the object files already created"
gcc -m64 -o arr.out manage.o input_array.o output_array.o sum_array.o main.o -fno-pie -no-pie -std=c17

echo "Run the program Assignment 2 - Array Management System"
./arr.out

echo "The bash script file is now closing."
