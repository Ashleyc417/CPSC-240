// Author: Ashley Chan
// Date: 10/25/2023
// // Program Name: Midterm Program Test

#include <stdio.h>

extern double manage();

int main()
{
    double result = 0.0;
    printf("Welcome to My Array by Ashley Chan.\n");
    result = manage();
    printf("The main received this number: %f and will study it.", result);
    printf("0 will be returned to the operating system.\n");
    return 0;
}
