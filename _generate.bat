@echo off

echo Building Generator
dotnet build ./generator/Generator.sln --configuration Debug

echo Running Generator
dotnet ./generator/Generator/bin/Debug/net6.0/Generator.dll  --input "dependencies.txt" --output "./source/fnf/psyche/api/EnvPopulator.hx"
