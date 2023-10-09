// ******************************************************************************************************************************************
// Program name: "Assignment 3 - Sort by Pointers".  This program demonstrates the use of cntl+d to terminate an input sequence.            *
// Copyright (C) 2023  Ashley Chan                                                                                                          *
//                                                                                                                                          *
// This file is part of the software program "Assignment 3 - Sort by Pointers".                                                             *
// "Assignment 3 - Sort by Pointers" is free software: you can redistribute it and/or modify it under the terms of the GNU General Public   *
// License version 3 as published by the Free Software Foundation.                                                                          *
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied                       *
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.                   *
// A copy of the GNU General Public License v3 has been distributed with this software. If not found it is available here:                  * 
// <https://www.gnu.org/licenses/>.   The copyright holder may be contacted here: ashleyc417@csu.fullerton.edu                              *
// ******************************************************************************************************************************************




// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
// Author information
//  Author name: Ashley Chan
//  Author email: ashleyc417@csu.fullerton.edu

// Program information
//  Program name: Assignment 3 - Sort by Pointers
//  Programming languages: Two module in C, One module in C++, Two module in X86-64, and One module in Bash.
//  Date program began: 2023-Oct-4
//  Date of last update: 2023-Oct-9
//  Files in this program: main.c, output_array.c, sorted_array.cpp, director.asm, input_array.asm, rx.sh
//  Status: This program was tested over a dozen times on Ubuntu 22.04.3 (Oct 2023) without errors.
//  Purpose: The intent of this program is to sort an inputted array and return the result.

// This file
//  Name: sorted_array.cpp
//  Language: C++
//  Purpose: Sort an inputted array with pointers




// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

extern "C" void sort_pointers(double*[], unsigned long);

void sort_pointers(double *arr[], unsigned long size) {
    bool swapped;
    for (unsigned long i = 0; i < size; ++i) {
        swapped = false;
        for (unsigned long j = 0; j < size - i - 1; ++j) {
            if(*(arr[j]) > *(arr[j + 1])) {
                // Swap arr[j] and arr[j + 1]
                double *temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
                swapped = true;
            }
        }
        // If no two elements are swapped by inner loop, break
        if (!swapped) {
            break;
        }
    } 
}