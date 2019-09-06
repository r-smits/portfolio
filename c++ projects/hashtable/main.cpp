#include <iostream>
#include <vector>

struct Flags
{
    bool LOOP = true;
    bool BREAK = true;
    int EXIT = true;
    
    int ERROR = false;
};


struct Node
{
    std::string key;
    int value;
    Node* next;
    
    Node(std::string k, int v) : key(k), value(v), next(NULL) {}
};

struct Hashtable
{
    Flags f;
    std::vector<Node> genData;
    std::vector<Node> hashtable;
    
    int ascii(Node &a)
    {
        int result = 0;
        
        for (int i = 0; i < a.key.size(); i += 1)
        {
            int k = a.key[i];
            if (k != 127) {result += k;}
        }
        
        return result;
    }
    
    std::string genStr(int &size)
    {
        std::string result = "";
        
        for (int i = 0; i < size; i += 1)
        {
            int r = (int)random();
            r = r % 128;
            
            char rc = r;
            result += rc;
        }
        
        return result;
    }
    
    int genVal(int &length)
    {
        
        (length > 4) ? length = 4 : length;
        
        std::string result = "";
        
        for (int i = 0; i < length; i += 1)
        {
            int r = (int)random();
            r = r % 10;
            result += std::to_string(r);
        }
        
        return std::stoi(result);
    }
    
    bool generateData(int n, int size)
    {
        Node temp("", 0);
        
        srand((unsigned int)time(0));
        
        for (int i = 0; i < n; i += 1)
        {
            if (i < n)
            {
                hashtable.push_back(temp);
            }
            
            Node a(genStr(size), genVal(size));
            genData.push_back(a);
        }
        
        return f.EXIT;
    }
    
    bool printData()
    {
        if (genData.size())
        {
            for (int i = 0; i < genData.size(); i += 1)
            {
                std::cout << "(" << genData[i].key << "," << genData[i].value << ")" << " ";
            }
            std::cout << std::endl;
            return f.EXIT;
        }
        else
        {
            std::cout << "Data not yet generated." << std::endl;
            return f.ERROR;
        }
    }
    
    bool printHashtable()
    {
        std::cout << "Contents of hash table: " << std::endl;
        
        for (int i = 0; i < hashtable.size(); i += 1)
        {
            
            std::cout << "index: "  << i << " (" << hashtable[i].key << ","
                                    << hashtable[i].value << ")" << " ";
            
            Node* n = &hashtable[i];
            
            while (n -> next)
            {
                n = n -> next;
                std::cout << "(" << n -> key << "," << n -> value << ")" << " ";
            }
            
            std::cout << std::endl;
        }
        return f.EXIT;
    }
    
    bool sort()
    {
        if (genData.size())
        {
            for (int i = 0; i < genData.size(); i += 1)
            {
                int hash = ascii(genData[i]);
                int index = hash % hashtable.size();
                
                if (hashtable[index].key == "")
                {
                    hashtable[index] = genData[i];
                }
                else
                {
                    Node* head = &hashtable[index];
                    
                    while (head -> next)
                    {
                        head = head -> next;
                    }
                    
                    head -> next = &genData[i];
                }
            }
        }
        else
        {
            return f.ERROR;
        }
        return f.EXIT;
    }
    
    bool find(std::string search)
    {
        Node temp(search, 0);
        int hash = ascii(temp);
        int index = hash % hashtable.size();
        
        //First hit?
        if (ascii(hashtable[index]) == hash)
        {
            std::cout << "Found entry at: " << index << std::endl;
            std::cout << "(" << hashtable[index].key << "," << hashtable[index].value << ")" << std::endl;
                return f.EXIT;
        }
        
        //Other hits possibly?
        Node* head = &hashtable[index];
            
        while (head -> next)
        {
            head = head -> next;
                
            if (ascii(*head) == hash)
            {
                std::cout << "Found entry at index: " << index << std::endl;
                std::cout << "(" << head -> key << "," << head -> value << ")" << std::endl;
                    
                return f.EXIT;
            }
        }
        
        std::cout << "Couldn't find the entry." << std::endl;
        return f.ERROR;
    }
    
};

struct initresult
{
    Hashtable h;
    bool DONE;
};


initresult init(Flags &f)
{
    //Instantiate objects
    Hashtable h;
    initresult i;

    //Generate data
    bool generated = h.generateData(5, 5);
    
    //Sort the data
    bool sorted = h.sort();
    
    if (generated && sorted)
    {
        i.DONE = f.EXIT;
        i.h = h;
                
        return i;
    }
    else
    {
        i.DONE = f.ERROR;
        return i;
    }
}


const bool loop(Hashtable &h)
{
    Flags f;
    
    std::string search = "";
    
    std::cout << "To stop searching, type 'exit'." << std::endl;
    std::cout << "To print the generated data, type 'printdata'." << std::endl << std::endl;
    std::cout << "To print the data in the hashtable, type 'printhash'." << std::endl << std::endl;
    
    while (f.LOOP)
    {
        
        std::cout << "Enter the key you want to look for: ";
        std::cin >> search;
        
        if (search == "stop")
        {return f.EXIT;}
        
        if (search == "printdata")
        {
            h.printData();
            continue;
        }
        
        if (search == "printhash")
        {
            h.printHashtable();
            continue;
        }
        
        h.find(search);
        
    }
    
    return f.ERROR;
}


int main()
{
    Flags f;
    
    
    initresult i = init(f);
    
    if(i.DONE)
    {
        loop(i.h);
    }
    else
    {
        std::cout << "Error, did not initialize correctly." << std::endl;
        return -1;
    }

    return 0;
}
