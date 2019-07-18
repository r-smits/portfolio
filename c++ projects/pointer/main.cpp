//
//  main.cpp
//  Pointer
//
//  Created by Ramon Smits on 23/06/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

#include <iostream>
#include "Header.hpp"

int main ()
{
    pointerTest pTest;
    
    int integer1 = *pTest.pointerInt(10);
    double double1 = *pTest.pointerDouble(5);
    long long1 = *pTest.pointerLong(2);
    
    pTest.printPointers(integer1, double1, long1);

    return 0;
}

int* pointerTest::pointerInt(int it1)
{
    int* iptr = &it1;
    return iptr;
}

double* pointerTest::pointerDouble(double db1)
{
    double* dptr = &db1;
    return dptr;
}

long* pointerTest::pointerLong(long lg1)
{
    long* lptr = &lg1;
    return lptr;
}

void pointerTest::printPointers(int int1, double double1, long long1)
{
    std::cout << int1 << std::endl;
    std::cout << double1 << std::endl;
    std::cout << long1 << std::endl;
}
