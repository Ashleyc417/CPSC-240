# Program name: "Work Calculator". This program calculate the work performed 
# based on volts, resistance and time with input validation for float input

# This file is part of the software program "Work Calculator".

# Author information
#   Author name : Ashley Chan
#   Author email: ashleyc417@csu.fullerton.edu
#   Author section: 240-3
#   Author CWID : 885814376

echo "Welcome to \"Work Calculator\""
echo "Compiling the ampere file..."
gcc -c -m64 -Wall -fno-pie -no-pie -o ampere.o ampere.c -std=c17

echo "Compiling the faraday file..."
nasm -f elf64 -o faraday.o faraday.asm

echo "Compiling the isfloat file..."
nasm -f elf64 -o isfloat.o isfloat.asm

echo "Linking the object files..."
gcc -m64 -no-pie -o hw4.out -std=c17 isfloat.o ampere.o faraday.o #-fno-pie

echo "Running hw4.."
./hw4.out


