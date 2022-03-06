using System;
using System.Collections.Generic;
using System.Linq;

namespace Generator
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            string inputDirectory = GetInput("--input", args.ToList());
            string outputFile = GetInput("--output", args.ToList());
        }

        private static string GetInput(string key, IList<string> args)
        {
            int index = args.IndexOf(key);

            if (index == -1)
                throw new InvalidOperationException($"Required parameter \"{key}\" was not passed!");

            if (index == args.Count - 1)
                throw new InvalidOperationException($"No input followed \"{key}\"!");

            return args[index + 1];
        }
    }
}