using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace Generator
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            string inputDirectory = GetInput("--input", args.ToList());
            string outputFile = GetInput("--output", args.ToList());
            
            Console.WriteLine("Input directory: " + inputDirectory);
            Console.WriteLine("Output file: " + outputFile);

            HaxeDefinitionCollector collector = new();
            DirectoryInfo dir = new(inputDirectory);

            foreach (FileInfo file in dir.EnumerateFiles("**", SearchOption.AllDirectories))
            {
                if (file.Extension != ".hx" || file.Name is "Constants.hx" or "import.hx")
                    continue;
                
                collector.ReadFile(file.FullName);
            }
            
            // Console.WriteLine(string.Join('\n', collector.QualifiedDefinitions));

            WritableHaxeFile hxFile = new WritableHaxeFileBuilder()
                .WithPackage("fnf.psyche.api")
                .WithClassName("EnvPopulator")
                .WithImports("interpret.DynamicModule", "interpret.Env")
                .WithFunction(new WritableHaxeFileBuilder.HaxeFunctionBuilder()
                    .WithPublic()
                    .WithStatic()
                    .WithName("populate(env:Env)")
                    .WithContents(GetContents(collector.QualifiedDefinitions))
                    .Build()
                )
                .Build();
            
            // Console.WriteLine(hxFile);
            
            File.WriteAllText(outputFile, hxFile.ToString());
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

        private static string GetContents(IEnumerable<string> definitions)
        {
            StringBuilder contents = new();

            foreach (string definition in definitions)
            {
                contents.AppendLine($"env.addModule(\"{definition}\", DynamicModule.fromStatic({definition}));");
            }

            return contents.ToString();
        }
    }
}