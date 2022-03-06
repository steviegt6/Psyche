using System.Collections.Generic;

namespace Generator
{
    public class WritableHaxeFile
    {
        public class HaxeFunction
        {
            public bool Public = true;
            public bool Static = true;

            public string Contents = "";
        }
        
        public string ClassName = "";
        
        public List<string> Imports = new();
        public List<string> Usings = new();
        public List<HaxeFunction> Functions = new();
    }
}