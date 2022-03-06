package fnf.psyche;

import flixel.math.FlxMath;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

class PsycheFpsDisplay extends TextField
{
	private var cachedFrames:Array<FpsCache> = [];

	public function new(x:Float = 10, y:Float = 10)
	{
		super();

		this.x = x;
		this.y = y;

		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("_sans", 12, 0xFFFFFF);
		text = "";
	}

	public override function __enterFrame(deltaTime:Float)
	{
		var time = Sys.time();

		cachedFrames.push(new FpsCache(time, cachedFrames.length));

		while (cachedFrames[0].time < time - 1.0)
		{
			cachedFrames.shift();
		}

		text = "FPS: " + cachedFrames.length;
		text += "\nAvg. FPS: " + getAvgFps();
		text += "\nMemory " + FlxMath.roundDecimal(System.totalMemory / 1000000, 1) + "MB";
	}

	private function getAvgFps():Int
	{
		var total = 0;

		for (frame in cachedFrames)
		{
			total += frame.fps;
		}

		return Math.round(total / cachedFrames.length);
	}
}
