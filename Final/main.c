// Name: Ashley Chan
// Email: ashleyc417@csu.fullerton.edu
// Date: 12/06/23
// CWID: 885814376

#include <stdio.h>

extern int manage();

int main() {
	printf("\nWelcome to Array Management System\n");
	printf("This product is maintained by Ashley Chan at ashleyc417@csu.fullerton.edu\n");

	int result = manage();

	printf("\n\nThe main function received %i and will keep it for a while.\nPlease consider buying more software from our suite of commercial program.\nA zero will be returned to the operating system.Bye\n", result);

	return 0;
}
