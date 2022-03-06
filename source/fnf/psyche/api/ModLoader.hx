package fnf.psyche.api;

import haxe.Json;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Expr;
import haxe.macro.TypeTools;
import interpret.DynamicModule;
import interpret.Env;
import openfl.utils.Dictionary;
import sys.FileSystem;
import sys.io.File;

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
}

class ModFile
{
	/**
	 * Metadata information for a mod.
	 */
	public var metadata:ModMetadata;

	/**
	 * The base directory relative to `fnf.psyche.api.ModLoader.modDir`.
	 */
	public var directory:String;

	public function new()
	{
	}
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

	public static function load():Void
	{
		var env = new Env();

		if (!FileSystem.isDirectory(modDir))
		{
			FileSystem.createDirectory(modDir);
		}
		if (!FileSystem.exists(getModDir(enabledPath)))
		{
			File.saveContent(getModDir(enabledPath), Json.stringify({enabled: []}));
		}

		resolveEnabledMods();
		resolveMods();
		registerEnv(env);
		loadEnabledMods(env);

		env.link();
	}

	inline static public function getModDir(key:String):String
	{
		return modDir + "/" + key;
	}

	public static function resolveEnabledMods():Void
	{
		var enabledModsFile = File.getContent(getModDir(enabledPath));

		if (enabledModsFile.length > 1)
		{
			var enabledMods = Json.parse(enabledModsFile).enabled;

			trace("Enabled mods: " + PsycheUtils.combineStrings(enabledMods, ", "));
		}
	}

	public static function resolveMods():Void
	{
		if (resolvedMods.iterator().hasNext())
		{
			resolvedMods = new Dictionary();
		}

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
		trace("Purging missing mods...");

		for (mod in enabledMods)
		{
			if (!resolvedMods.exists(mod))
			{
				enabledMods.remove(mod);
				trace("Removed missing mod \"" + mod + "\" from enabled array!");
			}
		}

		var output = File.write(getModDir(enabledPath));
		output.writeString(Json.stringify({enabled: enabledMods}));

		for (mod in resolvedMods.iterator())
		{
			var file = resolvedMods[mod];

			loadMod(file);
		}
	}

	public static function loadMod(file:ModFile):Void
	{
		trace("Loading mod \"" + file.metadata.name + "\"... (" + file.directory + ")");
	}

	// TODO: This is hacky and terrible.
	public static function registerEnv(env:Env):Void
	{
		// env.addModule(pkg, DynamicModule.fromStatic());
	}
}
