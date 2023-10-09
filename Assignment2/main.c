// Author: Ashley Chan
// Date: 09/25/2023
// Program Name: Assignment 02

#include <stdio.h>
extern double manage();

int main () {
    // Initial prompt
    printf("\nWelcome to Array Management System\nThis product is maintained by Ashley Chan at ashleyc417@csu.fullerton.edu\n");
    
    double output = manage();
    printf("\nThe main function received %f and will keep it for a while.\nPlease consider buying more software from out suite of commercial program.\nA zero will be returned to the operating system. Bye\n", output);
    return 0;
}