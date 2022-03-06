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

                if (Public)
                    builder.Append("public ");

                if (Static)
                    builder.Append("static ");

                builder.AppendLine("function " + Name)
                    .AppendLine("{")
                    .AppendLine(Contents)
                    .Append('}');
                
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
                builder.AppendLine($"import {import};");
            
            foreach (string @using in Usings) 
                builder.AppendLine($"using {@using};");

            builder.AppendLine("class " + ClassName)
                .AppendLine("{");

            foreach (HaxeFunction function in Functions) 
                builder.AppendLine(function.ToString());

            builder.Append('}');

            return builder.ToString();
        }
    }
}