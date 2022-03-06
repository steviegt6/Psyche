package fnf;

import flixel.FlxSprite;

class ModchartSprite extends FlxSprite
{
	public var wasAdded:Bool = false;

	// public var isInFront:Bool = false;

	public function new(?x:Float = 0, ?y:Float = 0)
	{
		super(x, y);
		antialiasing = ClientPrefs.globalAntialiasing;
	}
}
