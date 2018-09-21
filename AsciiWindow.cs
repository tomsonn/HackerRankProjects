/*********************
* 
*  ---------
*  |...|...|
*  |...|...|
*  |...|...|
*  |---+---|    N = 3;
*  |...|...|
*  |...|...|
*  |...|...|
*  ---------
*  
**********************/ 

using System;
using System.Collections;

namespace ascii
{
    class Solution
    {
        public static void HalfWin(int n)
        {
            for (int i = 0; i < n; i++)
            {
                for (int j = 0; j < n * 2 + 3; j++)
                {
                    if (j == 0 || j == n + 1 || j == n * 2 + 2)
                        Console.Write('|');
                    else
                        Console.Write('.');
                }
                Console.WriteLine();
            }

        }

        public static void Main(string[] args)
        {
            int N = int.Parse(Console.ReadLine());

            for (int i = 0; i < 5; i++)
            {
                for (int j = 0; j < N*2+3; j++)
                {
                    if (i == 0 || i == 4)
                    {
                        if (j == N * 2 + 2)
                            Console.WriteLine('-');
                        else
                            Console.Write('-');
                    }
                    else if (i == 2)
                    {
                        if (j == 0)
                            Console.Write('|');
                        else if (j == N + 1)
                            Console.Write('+');
                        else if (j == N * 2 + 2)
                            Console.WriteLine('|');
                        else
                            Console.Write('-');
                    }
                    else
                    {
                        HalfWin(N);
                        break;
                    }
                }
            }
        }
    }
}
