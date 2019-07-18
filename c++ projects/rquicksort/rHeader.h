//
//  rHeader.h
//  rQuickArray
//
//  Created by Ramon Smits on 18/07/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

#ifndef rHeader_h
#define rHeader_h

#include <iostream>
#include <vector>
#include <ctime>

class rQS
{
    
public:
    void swap(std::vector<int> &v, long l, long r);
    void rQuickSort(std::vector<int> &v, int min, int max);
    std::vector<int> rVec(int i);
    void print(std::vector<int> &v);

private:
    void printStats(int i, int j, int p);
    
};

void rQS::swap(std::vector<int> &v, long l, long r)
{
    int p = v[l];
    v[l] = v[r];
    v[r] = p;
}

void rQS::rQuickSort(std::vector<int> &v, int min, int max)
{
    int i = min;
    int j = max;
    int p = v[max];
    
    while (i < j)
    {
        
        if (v[i] > p)
        {
            swap(v, i, j-1);
            swap(v, j-1, j);
            
            j -= 1.0f;
        }
        else
        {
            i += 1.0f;
        }
        
    }
    
    while (j > min)
    {
        rQuickSort(v, min, j-1);
        break;
    }
    
    while (i < max)
    {
        rQuickSort(v, j+1, max);
        break;
    }
    
}

void rQS::print(std::vector<int> &v)
{
    int x = 0;
    
    while (x <= v.size()-1)
    {
        std::cout << " " << v[x] << " ";
        x += 1;
    }
    std::cout << std::endl;
}

std::vector<int> rQS::rVec(int i)
{
    std::vector<int> result;
    
    for (int j = 0; j < i; j +=1)
    {
        result.push_back(rand() %10);
    }
    
    return result;
    
}

void rQS::printStats(int i, int j, int p)
{
    std::cout << "i: " << i << " ";
    std::cout << "j: " << j << " ";
    std::cout << "p: " << p << std::endl;
}

#endif /* rHeader_h */
