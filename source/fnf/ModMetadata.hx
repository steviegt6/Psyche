package fnf;

import flixel.util.FlxColor;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;

class ModMetadata
{
	public var folder:String;
	public var name:String;
	public var description:String;
	public var color:FlxColor;
	public var restart:Bool; // trust me. this is very important
	public var alphabet:Alphabet;
	public var icon:AttachedSprite;

	public function new(folder:String)
	{
		this.folder = folder;
		this.name = folder;
		this.description = "No description provided.";
		this.color = ModsMenuState.defaultColor;
		this.restart = false;

		// Try loading json
		var path = Paths.mods(folder + '/pack.json');
		if (FileSystem.exists(path))
		{
			var rawJson:String = File.getContent(path);
			if (rawJson != null && rawJson.length > 0)
			{
				var stuff:Dynamic = Json.parse(rawJson);
				// using reflects cuz for some odd reason my haxe hates the stuff.var shit
				var colors:Array<Int> = Reflect.getProperty(stuff, "color");
				var description:String = Reflect.getProperty(stuff, "description");
				var name:String = Reflect.getProperty(stuff, "name");
				var restart:Bool = Reflect.getProperty(stuff, "restart");

				if (name != null && name.length > 0)
				{
					this.name = name;
				}
				if (description != null && description.length > 0)
				{
					this.description = description;
				}
				if (colors != null && colors.length > 2)
				{
					this.color = FlxColor.fromRGB(colors[0], colors[1], colors[2]);
				}

				this.restart = restart;
				/*
					if(stuff.name != null && stuff.name.length > 0)
					{
						this.name = stuff.name;
					}
					if(stuff.description != null && stuff.description.length > 0)
					{
						this.description = stuff.description;
					}
					if(stuff.color != null && stuff.color.length > 2)
					{
						this.color = FlxColor.fromRGB(stuff.color[0], stuff.color[1], stuff.color[2]);
				}*/
			}
		}
	}
}
