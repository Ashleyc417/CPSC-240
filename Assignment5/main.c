// Program name: "Random Number Normalization". This program fill an array with up to
// element with a random number and normalize them into a number within the range of 
// 1.0 and 2.0

// This file is part of the software program "Random Number Normalization".

// Author information
//   Author name : Ashley Chan
//   Author email: ashleyc417@csu.fullerton.edu
//   Author section: 240-3
//   Author CWID : 885814376

#include "stdio.h"

extern char* executive();

int main()
{
    printf("Welcome to Random Number Normalization, LLC.\n");
    printf("This software is maintained by Khoa Nguyen\n\n");

    char* result = executive();

    printf("\nOh, %s. We hope you enjoyed your arrays. Do come again.\n", result);
    printf("A zero will be returned to the operating system.\n");

    return 0;
}