#include <iostream>
#include <vector>

struct XO
{
    int data;
    char ch;
    
    XO(int a) : data(a)
    {
        (a == 1) ? ch = 'X' : ch = 'O';
        (a == -10) ? ch = '-' : ch;
    }
};


class Board
{
private:
    std::vector<std::vector<XO>> board;
    
public:
    
    void createABoard()
    {
        for (int i = 0; i < 3; i += 1)
        {
            std::vector<XO> row;
            
            XO empty(-10);
            
            row.push_back(empty);
            row.push_back(empty);
            row.push_back(empty);
            
            board.push_back(row);
        }
    }
    
    void printBoard()
    {
        
        std::cout << std::endl;
        
        for (int i = 0; i < 3; i += 1)
        {
            for (int j = 0; j < 3; j += 1)
            {
                (j > 0) ? std::cout << "|" << board[i][j].ch : std::cout << board[i][j].ch;
            }
            std::cout << std::endl;
        }
        
        std::cout << std::endl;
    }
    
    
    bool inputToken(int playerID, int bx, int by)
    {
        if (bx <= 3 && by <= 3 && by >= 1 && bx >= 1 && board[by-1][bx-1].data == -10)
        {
            (playerID == 1) ? board[by-1][bx-1] = XO(1) : board[by-1][bx-1] = XO(2);
            return true;
        }
        else
        {
            std::cout << "Input is invalid." << std::endl;
            return false;
        }
    }
    
    int winningCondition()
    {
        
        //Horizontal
        if (board[0][0].data + board[0][1].data + board[0][2].data == 3) {return 1;}
        if (board[1][0].data + board[1][1].data + board[1][2].data == 3) {return 1;}
        if (board[2][0].data + board[2][1].data + board[2][2].data == 3) {return 1;}
        
        if (board[0][0].data + board[0][1].data + board[0][2].data == 6) {return 2;}
        if (board[1][0].data + board[1][1].data + board[1][2].data == 6) {return 2;}
        if (board[2][0].data + board[2][1].data + board[2][2].data == 6) {return 2;}
        
        
        //Vertical
        if (board[0][0].data + board[1][0].data + board[2][0].data == 3) {return 1;}
        if (board[0][1].data + board[1][1].data + board[2][1].data == 3) {return 1;}
        if (board[0][2].data + board[1][2].data + board[2][2].data == 3) {return 1;}
        
        if (board[0][0].data + board[1][0].data + board[2][0].data == 6) {return 2;}
        if (board[0][1].data + board[1][1].data + board[2][1].data == 6) {return 2;}
        if (board[0][2].data + board[1][2].data + board[2][2].data == 6) {return 2;}
        
        
        //Diagonal
        if (board[0][0].data + board[1][1].data + board[2][2].data == 3) {return 1;}
        if (board[0][2].data + board[1][1].data + board[2][0].data == 3) {return 1;}
        
        if (board[0][0].data + board[1][1].data + board[2][2].data == 6) {return 2;}
        if (board[0][2].data + board[1][1].data + board[2][0].data == 6) {return 2;}
     
        return 0;
    }
    
};


Board init()
{
    //Object class
    Board b;
    
    b.createABoard();
    b.printBoard();
    
    return b;
}

void loop(Board &b)
{
    
    int px;
    int py;
    bool RUNNING = true;
    
    
    while (RUNNING)
    {
        std::cout << "Player 1, choose where you want to add the tokens." << std::endl;
        std::cin >> px >> py;
    
        while (!b.inputToken(1, px, py))
        {
            std::cin.clear();
            std::cin.ignore(256,'\n');
            std::cin >> px >> py;
        }
        
        b.printBoard();
        
        if (int w = b.winningCondition())
        {
            std::cout << "Player " << w << " wins the game." << std::endl;
            RUNNING = false;
            break;
        }
        
        std::cout << "Player 2, choose where you want to add the tokens." << std::endl;
        std::cin >> px >> py;
        
        while (!b.inputToken(2, px, py))
        {
            std::cin.clear();
            std::cin.ignore(256,'\n');
            std::cin >> px >> py;
        }
        
        b.printBoard();
        
        if (int w = b.winningCondition())
        {
            std::cout << "Player " << w << " wins the game." << std::endl;
            RUNNING = false;
            break;
        }
        
     
    }
    
}



int main()
{
    Board b = init();
    loop(b);
    
    return 0;
}
