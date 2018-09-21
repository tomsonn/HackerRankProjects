/*
 * The main goal was gather input:
 * n as number of pairs
 * each pair consist of value and key, string and float
 * we have to sort it in descending order (from the farthest to the closest element in our view)
 * and print it as standard output
 */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SortValues
{
    class SortingViewDistance
    {
        static void Main(string[] args)
        {
            int n = int.Parse(Console.ReadLine());
            Dictionary<string, float> dc = new Dictionary<string, float>();

            for (int i = 0; i < n; i++)
            {
                string[] input = Console.ReadLine().Split(' ');
                dc.Add(input[0], float.Parse(input[1]));
            }

            var sortedDic = from d in dc
                            orderby d.Value descending
                            select d;

            foreach (KeyValuePair<string, float> pair in sortedDic)
                Console.Write($"{pair.Key} ");
        }
    }
}
