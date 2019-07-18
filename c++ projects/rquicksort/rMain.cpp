//
//  main.cpp
//  rQuickArray
//
//  Created by Ramon Smits on 17/07/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

#include "rHeader.h"

int main()
{
    rQS rQS;
    
    std::vector<int> v = rQS.rVec(56);
    std::cout << "Start:" << std::endl;
    rQS.print(v);
    rQS.rQuickSort(v, 0, v.size()-1);
    std::cout << "Finished:" << std::endl;
    rQS.print(v);

    return 0;
}
