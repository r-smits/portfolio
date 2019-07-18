//
//  Header.hpp
//  Pointer
//
//  Created by Ramon Smits on 23/06/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

#ifndef Header_hpp
#define Header_hpp

#include <iostream>

class pointerTest
{
    
public:
    int* pointerInt(int it1);
    double* pointerDouble(double db1);
    long* pointerLong(long lg1);
    
    void printPointers(int int1, double double1, long long1);
};

#endif /* Header_hpp */
