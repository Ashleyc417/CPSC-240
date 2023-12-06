# !/bin/bash

# Program name: "Random Number Normalization". This program fill an array with up to
# element with a random number and normalize them into a number within the range of 
# 1.0 and 2.0

# This file is part of the software program "Random Number Normalization". 

# Author information
#   Author name : Ashley Chan
#   Author email: ashleyc417@csu.fullerton.edu
#   Author section: 240-3
#   Author CWID : 885814376

echo "Compiling the main file..."
gcc -c -m64 -Wall -fno-pie -no-pie -o main.o main.c -std=c17

echo "Compiling the benchmark file..."
nasm -f elf64 -o benchmark.o benchmark.asm

echo "Linking the object files..."
gcc -m64 -no-pie -o hw6.out -std=c17 benchmark.o main.o #-fno-pie

echo "Running hw6.."
./hw6.out