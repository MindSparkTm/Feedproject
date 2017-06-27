import java.util.Arrays;
import java.util.Scanner;

public class PrimeNumbers {
	//Overall run time complexity of the code below is O(n2)
	public static void main(String[] args) {
		int [] num = {1,2,3,5,7}; //---O(1)
		int max;
		System.out.println("Enter the maxmimum number for the prime number generator");
		Scanner input = new Scanner(System.in);
		max = input.nextInt();
		
		boolean[] numberList = new boolean[max + 1];//---O(1)
		int count = 1; //---O(1)
		int width = 10; //---O(1)

		//System.out.println(checkifnumberistwinprime(111,num));
		// Omit all odd non-prime numbers.
		for(int i = 3; i <= Math.sqrt(max); i += 2) //O(n)
		{
			for(int j = i; i * j <=max; j += 2) // O(n)
			{
				numberList[i*j] = true; //O(1) 
			}
		}
// O(n2)
		
		// Display prime numbers.
		//Overall runtime for the code below --O(n)
		for(int i = 3; i <=max; i += 2)//O(n)
		{
			//Overall runtime of the code below O(n)
			// Display number if element was not set.
			if (!numberList[i]) //o(1)
			{
				int res = checkifnumberistwinprime(i,num);//o(n)
				if(res>0) ////o(1)
				{
				System.out.print(i+"\t"); ////o(1)
				}
				count++;////o(1)

			}
			
			// Set number of columns in STDOUT.
			if (count == width)//o(1)
			{
				System.out.println();//o(1)
				count = 0;//o(1)
			}//o(1)
		}
		System.out.println();//o(1)
	}
	
	
	public static int checkifnumberistwinprime(int n,int[]arr)
	{
		int flag = 0;//o(1)
		
		while (n > 0) { //o(n)
			  int d = n / 10;//o(1)
			  int k = n - d * 10;//o(1)
			  n = d;//o(1)
			 
			  
			  boolean found = Arrays.binarySearch(arr, k) > -1;//O(logn)
			  if(!found){//o(1)
				  flag =0;//o(1)
				  break;//o(1)
				  
			  }
			  
			  else{//o(1)
				  
				   flag = flag +1;//o(1)
				   if(n<10){//o(1)
			      found = Arrays.binarySearch(arr, n) > -1;//O(logn)
			      if(!found){//o(1)
			    	  flag=0;//o(1)
			    	  break;//o(1)
			      }
			      else//o(1)
			      {
			    	  flag = flag +1;//o(1)
			    	  break;//o(1)
			      }
				   }
			  }
			  
			 
			}	
		return flag;//o(1)
		
	}
		
	
	
}