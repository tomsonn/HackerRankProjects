using System;
using System.Linq;
using System.IO;
using System.Text;
using System.Collections;
using System.Collections.Generic;

class Solution
{
    static void Main(string[] args)
    {
        string[] inputs = Console.ReadLine().Split(' ');
        int n = int.Parse(inputs[0]);
        int m = int.Parse(inputs[1]);
        
        int[] min = new int[n];
        int[] max = new int[n];

        for (int i = 0; i < n; i++)
        {
            if (n == m)
            {
                if (i == 0)
                    min[i] = 1;
                else if (i == 1)
                    min[i] = 0;
                else
                    min[i] = i;
            }
            else
            {
                if (i == 0)
                    min[i] = 1;
                else if (i > 0 && i <= n - m + 1)
                    min[i] = 0;
                else
                    min[i] = i - n + m;
            }
        }
        for (int i = 0; i < n; i++)
        {
            if (n == m)
                max[i] = 9 - i;
            else
            {
                if (i >= 0 && i <= n - m)
                    max[i] = 9;
                else
                    max[i] = 9 - i + n - m;
            }
        }

        for (int i = 0; i < min.Length; i++)
        {
            Console.Write($"{min[i]}");

        }
        Console.Write(" ");
        for (int i = 0; i < min.Length; i++)
        {
            Console.Write($"{max[i]}");
        }

    }
}