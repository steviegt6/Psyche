using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Generator
{
    public class HaxeModuleCollector
    {
        /// <summary>
        ///     A collection of fully-qualified (package + name) type definitions (interfaces, typedefs, classes, etc.)
        /// </summary>
        public readonly List<string> QualifiedDefinitions = new();

        public void ReadFile(string file)
        {
            string fileName = Path.GetFileNameWithoutExtension(file);
            string[] lines = File.ReadAllLines(file);

            string? package = null;
            
            foreach (string line in lines)
            {
                if (line.StartsWith("package ") && line.EndsWith(';'))
                {
                    package = line.Remove(0, "package ".Length);
                    package = package.Remove(package.Length - 1);
                    break;
                }

                if (line != "package;")
                    continue;
                
                package = "";
                break;
            }

            // if (package is null)
            //     throw new Exception($"Error while reading \"{file}\": No package was provided!");

            package ??= "";
            
            if (!string.IsNullOrWhiteSpace(package))
                package += '.';

            QualifiedDefinitions.Add(package + fileName);
        }
    }
}