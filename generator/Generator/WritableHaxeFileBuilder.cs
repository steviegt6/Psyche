using System.Collections.Generic;

namespace Generator
{
    public class WritableHaxeFileBuilder
    {
        public class HaxeFunctionBuilder
        {
            private WritableHaxeFile.HaxeFunction Function = new();

            public HaxeFunctionBuilder WithPublic(bool value = true)
            {
                Function.Public = value;
                return this;
            }
            
            public HaxeFunctionBuilder WithStatic(bool value = true)
            {
                Function.Static = value;
                return this;
            }
            
            public HaxeFunctionBuilder WithContents(string value)
            {
                Function.Contents = value;
                return this;
            }

            public WritableHaxeFile.HaxeFunction Build()
            {
                return Function;
            }
        }

        private WritableHaxeFile File = new();

        public WritableHaxeFileBuilder WithClassName(string value)
        {
            File.ClassName = value;
            return this;
        }
        
        public WritableHaxeFileBuilder WithImport(string value)
        {
            File.Imports.Add(value);
            return this;
        }
        
        public WritableHaxeFileBuilder WithImports(params string[] value)
        {
            File.Imports.AddRange(value);
            return this;
        }
        
        public WritableHaxeFileBuilder WithUsing(string value)
        {
            File.Usings.Add(value);
            return this;
        }
        
        public WritableHaxeFileBuilder WithUsings(params string[] value)
        {
            File.Usings.AddRange(value);
            return this;
        }
        
        public WritableHaxeFileBuilder WithFunction(WritableHaxeFile.HaxeFunction value)
        {
            File.Functions.Add(value);
            return this;
        }
        
        public WritableHaxeFileBuilder WithFunctions(params WritableHaxeFile.HaxeFunction[] value)
        {
            File.Functions.AddRange(value);
            return this;
        }

        public WritableHaxeFile Build()
        {
            return File;
        }
    }
}