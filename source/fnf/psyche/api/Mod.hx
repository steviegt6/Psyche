package fnf.psyche.api;

import fnf.psyche.eventbus.DependencyContext;

abstract class Mod
{
	public var name(default, null):String;
	public var internalName(default, null):String;
	public var version(default, null):String;

	public function new(name:String, internalName:String, version:String)
	{
		this.name = name;
		this.internalName = internalName;
		this.version = version;
	}

	/**
	 * A function that is called when the mod is loaded. Useful to listening to events.
	 */
	public function load():Void
	{
	}

	/**
	 * Automatically used to hook into the main dependency injector.
	 * @param context The dependency injection context.
	 */
	public function injectDependencies(context:DependencyContext):Void
	{
	}
}
