

class hourglass
{

	static void printArr(int[][] arr)
	{

		for(int i = 0; i<arr.length; i+=1)
		{
			for(int j = 0; j < arr[0].length; j +=1)
			{

				System.out.print(arr[i][j] + " ");

			}

			System.out.println("");
		}
	}


	static int hourglassSum(int[][] arr)
	{

		printArr(arr);

		int csum = 0;
		int tsum = -99;

		for (int i = 0; i < arr.length-2; i += 1)
		{

			for (int j = 0; j < arr[0].length-2; j += 1)
			{

				csum = 0;

				csum = csum + arr[i][j];
				csum = csum + arr[i][j+1];
				csum = csum + arr[i][j+2];

				csum = csum + arr[i+1][j+1];

				csum = csum + arr[i+2][j];
				csum = csum + arr[i+2][j+1];
				csum = csum + arr[i+2][j+2];

				if (csum > tsum)
				{
					System.out.println("csum: > tsum -- " + csum + " > " + tsum);
					tsum = csum;
				}

			}

		}

		return tsum;

	}

	public static void main(String[] args)
	{

		int interval = 0;

		int[][] arr = new int[6][6];



		for(int i=0; i<6; i+=1)
		{

			for (int j = 0; j < 6; j+=1)
			{
				arr[i][j] = interval;

				interval += 1;

			}
		}

		int result = hourglassSum(arr);

		System.out.println(result);

	}


}

