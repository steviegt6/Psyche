package fnf.psyche;

import sys.FileSystem;

class PsycheUtils
{
	public static function combineStrings(strings:Array<String>, separator:String):String
	{
		var string:String = "";

		for (i => str in strings)
		{
			string += str;

			if (i != strings.length - 1)
			{
				string += separator;
			}
		}

		return string;
	}

	public static function readDirectoryRecursive(path:String, callback:String->Void):Void
	{
		for (dir in FileSystem.readDirectory(path))
		{
			if (FileSystem.isDirectory(dir))
			{
				readDirectoryRecursive(path + "/" + dir, callback);
			}
			else
			{
				callback(path + "/" + dir);
			}
		}
	}
}
