using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Generator
{
    public class HaxeDefinitionCollector
    {
        public readonly struct Definition
        {
            public readonly string Qualifier;
            public readonly Func<string[], string> NameSupplier;

            public Definition(string qualifier, Func<string[], string> nameSupplier)
            {
                Qualifier = qualifier;
                NameSupplier = nameSupplier;
            }
        }

        public static readonly List<Definition> Definitions = new()
        {
            new Definition("abstract class", args => args[2]),
            new Definition("class abstract", args => args[2]),
            // new Definition("enum abstract", args => args[2]),
            // new Definition("abstract enum", args => args[2]),
            new Definition("class", args => args[1]),
            new Definition("interface", args => args[1]),
            // new Definition("typedef", args => args[1]),
            // new Definition("enum", args => args[1])
        };

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

            if (package is null)
                throw new Exception($"Error while reading \"{file}\": No package was provided!");

            if (!string.IsNullOrWhiteSpace(package))
                package += '.';

            foreach (string line in lines)
            {
                string[] words = line.Split(' ');
                
                foreach (Definition def in Definitions.Where(def => line.StartsWith(def.Qualifier)))
                {
                    string name = def.NameSupplier(words);
                    
                    // Skip over classes with generic types :(
                    if (name.Contains('<') && name.Contains('>'))
                        goto SkipDefs;

                    if (name != fileName)
                        name = fileName + '.' + name;
                    
                    QualifiedDefinitions.Add(package + name);
                    goto SkipDefs;
                }
                
                SkipDefs: ;
            }
        }
    }
}