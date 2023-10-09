
//  Copyright (C) 2023 Ashley Chan                                                                                       
                                                                                                                           
//  This file is part of the software program "Assignment 03 - Sort By Pointers" and you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 3 as published by the Free Software Foundation. 
                                                           
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY without even the implied         
//  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.     
//  A copy of the GNU General Public License v3 has been distributed with this software. If not found it is available here:  
//  <https://www.gnu.org/licenses/>. The copyright holder may be contacted here: ashleyc417@csu.fullerton.edu.                    

// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3

// Author information
//   Author name: Ashley Chan
//   Author email: ashleyc417@csu.fullerton.edu

// Program information
//   Program name: Director
//   Programming languages: One modules in C, three modules in X86-64, and one module in Bash.
//   Date program began: 2023-Sep-30
//   Date of last update: 2023-Oct-9
//   Files in this program: main.c, director.asm, input_array.asm, output_array.asm, rx.sh

// This file
//   Name: control-d.asm
//   Language: X86-64
//   Syntax: Intel

// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3

#include <stdio.h>
extern double **director(unsigned long *n);

int main () {
    printf("\nWelcome to a great program developed by Ashley Chan.\n");
    
    unsigned long size = 0;
    double **arr = director(&size);

    printf("\nThe main function received this set of numbers: \n");
    for (unsigned long i = 0; i < size; i++) {
        printf("%1.10lf\n", *(arr[i]));
    }

    printf("Main will keep these and send a zero to the operating system.\n");
    return 0;
}