package mods.mania;

import fnf.psyche.api.Mod;
import fnf.psyche.eventbus.DependencyContext;

class ManiaMod extends Mod
{
	public function new() {}

	public override function load():Void
	{
		trace("Test logging.");
	}

	public override function injectDependencies(context:DependencyContext):Void {}
}
