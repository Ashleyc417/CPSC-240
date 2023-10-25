// Author: Ashley Chan
// Date: 10/25/2023
// Program Name: Midterm Program Test

#include <stdio.h>

extern void output_array(double *[], unsigned long);

// Prints elements in array by dereferencing the value pointed at each index
void output_array(double *arr[], unsigned long size) {
    for (unsigned long i = 0; i < size; ++i) {
      printf("%1.10lf\n", *(arr[i]));
    }
}


