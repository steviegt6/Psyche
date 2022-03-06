using System.Collections.Generic;
using System.Text;

namespace Generator
{
    public class WritableHaxeFile
    {
        public class HaxeFunction
        {
            public bool Public = true;
            public bool Static = true;
            public string Name = "";
            
            public string Contents = "";
            
            public override string ToString()
            {
                StringBuilder builder = new();

                builder.Append('\t');
                
                if (Public)
                    builder.Append("public ");

                if (Static)
                    builder.Append("static ");

                builder.AppendLine("function " + Name)
                    .AppendLine("\t{")
                    .AppendLine(Contents)
                    .AppendLine("\t}")
                    .Append($"\t// Auto-generated function \"{Name}\" for Psyche (https://github.com/Steviegt6/Psyche/).");
                
                return builder.ToString();
            }
        }

        public string Package = "";
        public string ClassName = "";

        public List<string> Imports = new();
        public List<string> Usings = new();
        public List<HaxeFunction> Functions = new();

        public override string ToString()
        {
            StringBuilder builder = new();

            builder.AppendLine($"package {Package};");

            foreach (string import in Imports) 
                builder.Append($"\nimport {import};");
            
            foreach (string @using in Usings) 
                builder.Append($"\nusing {@using};");

            builder.AppendLine("\n\nclass " + ClassName)
                .AppendLine("{");

            foreach (HaxeFunction function in Functions) 
                builder.AppendLine(function.ToString());

            builder.AppendLine("}")
                .AppendLine($"// Auto-generated class \"{ClassName}\" for Psyche (https://github.com/Steviegt6/Psyche/).");

            return builder.ToString();
        }
    }
}