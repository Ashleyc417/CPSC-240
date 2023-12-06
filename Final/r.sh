#!/usr/bin/env bash

# Name: Joel Daniel Rico
# CWID: 885687517
# Email: joeldanielrico@csu.fullerton.edu
# Date: 12/06/23

echo "======================================================"

echo "Tested on: NASM version 2.16.01"
if command -v nasm &> /dev/null
then
	echo "Your NASM version: $(nasm -v)"
	echo ""
fi

rm -f ./*.o
find . -type f  ! -name "*.*"  -delete

echo "Compiling the main file..."
gcc -c -m64 -Wall -fno-pie -no-pie -o main.o main.c -std=c17

echo "Compiling the manage file..."
nasm -f elf64 -o manage.o manage.asm

echo "Compiling the input_array file..."
nasm -f elf64 -o input_array.o input_array.asm

echo "Compiling the output_array file..."
nasm -f elf64 -o output_array.o output_array.asm


echo "Linking the object files..."
gcc -m64 -no-pie -o final.out -std=c17 manage.o main.o input_array.o output_array.o #-fno-pie

echo "Running final.."
./final.out