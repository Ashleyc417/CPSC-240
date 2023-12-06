

#include "stdio.h"

extern unsigned long benchmark();

int main()
{
    printf("Welcome to Langsdorff Benchmark Program by Khoa Nguyen.\n");

    unsigned long result = benchmark();

    printf("The driver received this number %ld\n", result);
    printf("Now 0 will be sent to the operating system. Bye\n");

    return 0;
}