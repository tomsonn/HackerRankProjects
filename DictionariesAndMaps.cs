/*
The task was to create a Dictionary/Map/HashMap to match key, which is the name and value which is phone number.
After that we got unknown number of names and we tried to got their number from that collections.
If there wasnt tested name, we printed "Not found" as output.
*/


using System;
using System.Collections.Generic;
using System.IO;
class Solution
{
    static void Main(String[] args)
    {
        Dictionary<string, string> dc = new Dictionary<string, string>();
        int n = int.Parse(Console.ReadLine());

        for (int i = 0; i < n; i++)
        {
            string[] values = Console.ReadLine().Split(' ');
            dc.Add(values[0], values[1]);
        }

        string line;
        while ((line = Console.ReadLine()) != null)
        {
            string value = String.Empty;
            if (dc.TryGetValue(line, out value))
                Console.WriteLine($"{line}={value}");
            else
                Console.WriteLine("Not found");
        }
    }
}
