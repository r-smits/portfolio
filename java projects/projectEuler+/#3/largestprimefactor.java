import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

class largestprimefactor 
{

    public static void main(String[] args) 
    {


    	Long[] ex = {10L, 41L, 928L, 102343L, 102300L};

        for(int a0 = 0; a0 < ex.length; a0+=1){
        
            //number
            Long n = ex[a0];
            double x = Math.sqrt(n);
            
            
            //Catch even numbers

            while (n % 2 == 0)
            {
                n = n / 2;
            }

            if (n == 1)
            {
                System.out.println(2);
                continue;
            }

            for (int i = 3; i <= x; i += 2)
            {

                if (n % i == 0)
                {
                    n = n / i;

                    if (n == 1)
                    {
                        System.out.println(i);
                        break;
                    }

                    i = 1;
                }

            }

            if (n > 2)
            {
                System.out.println(n);
            }
            
    
        }
    }
}


