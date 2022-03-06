package fnf.psyche.api;

import haxe.Json;
import interpret.DynamicInstance;
import interpret.DynamicModule;
import interpret.Env;
import openfl.utils.Dictionary;
import sys.FileSystem;
import sys.io.File;

using StringTools;

typedef ModMetadata =
{
	/**
	 * The mod's display name.
	 */
	var name:String;

	/**
	 * A short description of the mod.
	 */
	var description:String;

	/**
	 * The qualified class name of your `Mod`-extending class.
	 */
	var entrypoint:String;
}

class ModLoader
{
	/**
	 * The directory in which mods reside.
	 */
	public static final modDir:String = "mods";

	/**
	 * Relative file path for the `enabled.json` file. Relative to `modDir`.
	 */
	public static final enabledPath:String = "enabled.json";

	public static var enabledMods:Array<String> = [];
	public static var resolvedMods:Dictionary<String, ModFile> = new Dictionary();
	public static var loadedMods:Array<DynamicInstance> = [];

	public static function load(env:Env):Void
	{
		resolveEnabledMods();
		resolveMods();
		loadEnabledMods(env);

		env.link();

		loadMods(env);
	}

	public static function getModDir(key:String):String
	{
		return modDir + "/" + key;
	}

	public static function resolveEnabledMods():Void
	{
		enabledMods = Json.parse(File.getContent(getModDir(enabledPath))).enabled;

		trace("Enabled mods: " + PsycheUtils.combineStrings(enabledMods, ", "));
	}

	public static function resolveMods():Void
	{
		for (dir in FileSystem.readDirectory(modDir))
		{
			if (!FileSystem.isDirectory(dir))
				continue;

			var modFile:ModFile = new ModFile();
			modFile.directory = dir;
			modFile.metadata = Json.parse(File.getContent(getModDir(dir + "/mod.json")));

			resolvedMods.set(modFile.directory, modFile);

			trace("Resolved mod \"" + modFile.metadata.name + "\" at: " + dir);
		}
	}

	public static function loadEnabledMods(env:Env):Void
	{
		/*trace("Purging missing mods...");

			var missing:Array<String> = [];

			for (mod in enabledMods)
			{
				if (!resolvedMods.exists(mod))
				{
					// enabledMods.remove(mod);
					missing.push(mod);
					trace("Removed missing mod \"" + mod + "\" from enabled array!");
				}
			}

			for (mod in missing)
			{
				enabledMods.remove(mod);
			}

			var output = File.write(getModDir(enabledPath));
			output.writeString(Json.stringify({enabled: enabledMods})); */

		for (mod in resolvedMods.iterator())
		{
			if (!enabledMods.contains(mod))
			{
				continue;
			}

			var file = resolvedMods[mod];

			loadMod(file, env);
		}
	}

	public static function loadMod(file:ModFile, env:Env):Void
	{
		trace("Loading mod file \"" + file.metadata.name + "\"... (" + file.directory + ")");

		// Load mod files into memory
		PsycheUtils.readDirectoryRecursive(getModDir(file.directory), function(path:String):Void
		{
			if (path.endsWith(".hx"))
			{
				var pkg = path.replace("/", ".").replace(".hx", "");

				trace("Loading file \"" + path + "\"... (" + pkg + ")");

				var code = File.getContent(path);
				var split = pkg.split(".");
				var name = split[split.length - 1];

				env.addModule(pkg, DynamicModule.fromString(env, name, code));
			}
		});
	}

	public static function loadMods(env:Env):Void
	{
		for (mod in resolvedMods.iterator())
		{
			var file = resolvedMods[mod];

			// Create a new mod object
			var parts = file.metadata.entrypoint.split(".");
			var modName = parts[parts.length - 1];

			var modClass = env.modules.get(file.metadata.entrypoint).dynamicClasses.get(modName);

			var modInstance = modClass.createInstance();
			loadedMods.push(modInstance);
		}

		for (mod in loadedMods)
		{
			mod.call("load");
		}
	}
}
