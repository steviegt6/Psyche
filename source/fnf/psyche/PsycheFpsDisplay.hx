package fnf.psyche;

import openfl.text.TextFormat;
import openfl.text.TextField;

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
		#if !js
		var time = Sys.time();

        cachedFrames.push(new FpsCache(time, cachedFrames.length));

		while (cachedFrames[0].time < time - 1.0)
		{
			cachedFrames.shift();
		}

		text = "FPS: " + cachedFrames.length;
		text += "\nAvg. FPS: " + getAvgFps();
		#else
		throw "Unsupported build target. Psyche doesn't support Web builds.";
		#end
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

class FpsCache
{
	public var time:Float;
	public var fps:Int;

	public function new(time:Float, fps:Int)
	{
		this.time = time;
		this.fps = fps;
	}
}
