import java.util.*;

class evenfibonacci {

    public static void main(String[] args) {

        int t = 3;

        long tn[] = new long[] {10, 100, 1000};

        for(int a0 = 0; a0 < t; a0++){

            long n = tn[a0];

            long a = 0;

            List<Long> lInt = new ArrayList<Long>();

            long one = 1;
            long two = 2;
            int i = 0;

            lInt.add(one);
            lInt.add(two);

            while (a < n)
            {
                //Move one entry forward in the list
                i += 1;

                //Storing new value
                if (a > 0)
                {
                lInt.add(a);
                }

                //Assigning new value
                a = lInt.get(i-1) + lInt.get(i);

                //Print for debug purposes
                //System.out.println("a: " + a + " = " + " lInt(i-1) = " + lInt.get(i-1) + " lInt(i)= " + lInt.get(i));
            }

            //Find sum of even numbers
            long sum = 0;

            for (int f = 0; f < lInt.size(); f += 1)
            {
                long x = lInt.get(f);
                
                if (x % 2 == 0)
                {
                    sum = sum + x;
                }
            }

            //Print result
            System.out.println(sum);

            
        }


    }
}


