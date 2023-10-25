#!/usr/bin/env bash

# Author: Ashley Chan
# Date: 10/25/2023
# Program Name: Midterm Program Test

echo "Tested on: NASM version 2.15.05"
if command -v nasm &> /dev/null
then
    echo "Your NASM version: $(nasm -v)"
    echo ""
fi
rm -f ./*.o
find . -type f  ! -name "*.*"  -delete

FILES=()

for file in *; do
    if [[ $file == *.asm ]]
    then
        file="$(basename "${file}" .asm)"
        nasm -f elf64 -o "${file}".o "${file}".asm 
        FILES+=("${file}.o")

    elif [[ $file == *.c ]]
    then
        file="$(basename "${file}" .c)"
        gcc -c -o "${file}".o "${file}".c
        FILES+=("${file}.o")
    
    elif [[ $file == *.cpp ]]
    then
        file="$(basename "${file}" .cpp)"
        g++ -o "${file}".o "${file}".cpp
        FILES+=("${file}.o")

    fi
done

OUTPUT_FILE="program"
gcc -no-pie "${FILES[@]}" -o "${OUTPUT_FILE}" -z noexecstack
rm -f ./*.o

./"${OUTPUT_FILE}"

