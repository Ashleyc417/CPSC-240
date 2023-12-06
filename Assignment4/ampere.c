// Program name: "Work Calculator". This program calculate the work performed 
// based on volts, resistance and time with input validation for float input

// This file is part of the software program "Work Calculator".

// Author information
//   Author name : Ashley Chan
//   Author email: ashleyc417@csu.fullerton.edu
//   Author section: 240-3
//   Author CWID : 885814376

#include "stdio.h"

extern double faraday();

int main()
{
    printf("Welcome to Majestic Power Systems, LLC\n");
    printf("Project Director, Sharon Winners, Senior Software Engineer.\n\n");

    double result = faraday();

    printf("\nThe main function received this number %lf and will keep it for future study.\n", result);
    printf("A zero will be returned to the operating system.  Bye.\n");

    return 0;
}

