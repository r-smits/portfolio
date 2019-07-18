//
//  main.cpp
//  ReverseLinkedList
//
//  Created by Ramon Smits on 22/06/2019.
//  Copyright © 2019 Ramon Smits. All rights reserved.
//

#include <iostream>

struct ListNode
{
    int val;
    ListNode* next;
    ListNode(int x) : val(x), next(NULL) {}
};

ListNode* createNodes(int nrNodes);
void add(ListNode* ptrNode);

void welcomeMessage(ListNode* list);
void printNodes(ListNode* ptrNode);



int main()
{
    ListNode* list = new ListNode(0);
    welcomeMessage(list);
    return 0;
}

void add(ListNode* ptrNode)
{
    if (ptrNode == NULL)
    {
        ptrNode -> val = 0;
    }
    else
    {
        while (ptrNode -> next != NULL)
        {
            ptrNode = ptrNode -> next;
        }
        
        ListNode* newNode = new ListNode(0);
        ptrNode -> next = newNode;
    }
}

void remove()
{
    
    
}

ListNode* createNodes(int nrNodes)
{
    
    ListNode* head = new ListNode(0);
    ListNode* previousNode = new ListNode(0);
    
    for (int i = 0; i < nrNodes; i = i + 1)
    {
        
        if (i == 0)
        {
            head -> val = i;
            previousNode = head;
        }
        else
        {
            ListNode* newNode = new ListNode(i);
            previousNode -> next = newNode;
            previousNode = newNode;
        }
    }
    
    return head;
}

void printNodes(ListNode* ptrNode)
{
    while (ptrNode -> next != NULL)
    {
        std::cout << ptrNode -> val << std::endl;
        ptrNode = ptrNode -> next;
    }
    
    std::cout << ptrNode -> val << std::endl;

}

void welcomeMessage(ListNode* list)
{
    int x;
    
    std::cout << "1 - Generate a linked list with x (n) nodes" << std::endl;
    std::cout << "2 - Add a node to the linked list" << std::endl;
    std::cout << "3 - Remove a node from the linked list" << std::endl << std::endl;
    
    std::cout << "Select your option." << std::endl << "> ";
    std::cin >> x;
    
    if (x==1)
    {list = createNodes(5);}
    
    if (x==2)
    {add(list);}
    
    if (x==3)
    {}
    
    if (x < 1 || x > 3)
    {return;}
    
    printNodes(list);
    
    welcomeMessage(list);
}
