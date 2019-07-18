//
//  main.cpp
//  PascalsTriangle
//
//  Created by Ramon Smits on 22/06/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

#include <iostream>
#include <vector>

std::vector<std::vector<int>> pascalsTriangle(int max);
void printTriangle(std::vector<std::vector<int>> result);
int prompt();

int main()
{
    std::vector<std::vector<int>> result = pascalsTriangle(prompt());
    printTriangle(result);
    return 0;
}

int prompt()
{
    int max;
    std::cout << "Enter the number for the rows of the triangle." << std::endl << "> ";
    std::cin >> max;
    
    return max;
}

std::vector<std::vector<int>> pascalsTriangle(int max)
{
    
    std::vector<int> rowVector;
    std::vector<std::vector<int>> returnVector;
    
    for (int i = 0; i < max; i = i + 1)
    {
        for (int j = 0; j < i + 1; j = j + 1)
        {
            rowVector.resize(i + 1);
            
            if (j == 0 || j == i)
            {
                rowVector[j] = 1;
            }
            else
            {
                rowVector[j] = returnVector[i-1][j-1] + returnVector[i-1][j];
            }
        }
        returnVector.push_back(rowVector);
    }
    
    return returnVector;
}


void printTriangle(std::vector<std::vector<int>> result)
{
    for (int x = 0; x < result.size(); x = x + 1)
    {
        for (int y = 0; y < result[x].size(); y = y + 1)
        {
            std::cout << "result[" << x << "][" << y << "]: " << result[x][y] << std::endl;
        }
        
        std::cout << std::endl;
    }
}
