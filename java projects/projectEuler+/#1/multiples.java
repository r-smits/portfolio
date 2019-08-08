
public class multiples {

    public static void main(String[] args) {

        int t = 3;

        int[] nt = new int[] {10, 100, 1000};

        for(int a0 = 0; a0 < t; a0++){

            long n = nt[a0] - 1;

            long sum = add(n / 3) * 3 + add(n / 5) * 5 - add(n / 15) * 15;

            print(sum);
        }

    }

    private static long add(long m)
    {
        return (m * (m + 1) / 2);
    }

    private static void print(long sum)
    {
        System.out.println(sum);
    }
}


