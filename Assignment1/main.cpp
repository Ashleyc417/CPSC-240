// Author: Ashley Chan
// Date: 09/05/2023
// Program Name: Assignment 01 - Las Vegas

#include <iostream>
#include <cstdlib>
#include <cstring>

extern "C" double las_vegas();

int main() {
    std::cout << "Welcome to Trip Advisor by Ashley Chan.\n";
    std::cout << "We help plan your trip.\n\n";

    // Call Function
    double output = las_vegas();

    std::cout << "The main module received this number " << output << " and will keep it for a while.\n";

    // Final output
    std::cout << "A zero will be sent to your operating system.\n";
    std::cout << "Good-bye. Have a great trip.\n";
}
