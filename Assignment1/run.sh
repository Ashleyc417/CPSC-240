#!/bin/bash

#Author: Ashley Chan
#Date: 09/05/2023
#Program Name: Assignment 01 - Las Vegas

rm -f *.o
rm -f *.out

echo "Assemble the module fp-io.asm"
nasm -f elf64 -l las_vegas.lis -o las_vegas.o las_vegas.asm

echo "Compile the C++ module fp-io-driver.cpp"
g++ -c -m64 -Wall -o main.o main.cpp -fno-pie -no-pie -std=c++17

echo "Link the two object files already created"

g++ -m64 -o las_vegas.out main.o las_vegas.o -fno-pie -no-pie -std=c++17 -lc

echo "Run the program - Las Vegas"
./las_vegas.out

echo "The bash script file is now closing."