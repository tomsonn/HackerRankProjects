using System;
using System.Collections;

namespace ascii
{
    class Solution
    {
        public static void HalfWin(int n)
        {
            Console.WriteLine();
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

        public static void main(string[] args)
        {
            int N = int.Parse(Console.ReadLine());

            HalfWin(N);
            HalfWin(N);
        }
    }
}