package fnf.psyche;

import openfl.text.TextFormat;
import openfl.text.TextField;

class PsycheFpsDisplay extends TextField {
    private var cachedFrames:Array<Float> = [];

    public function new(x:Float = 10, y:Float = 10) {
        super();

        this.x = x;
        this.y = y;

		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("_sans", 12, 0xFFFFFF);
		text = "";
    }

    public override function __enterFrame(deltaTime:Float) {
        #if !js
        var count = 0;
        var time = Sys.time();
        cachedFrames.push(time);

        for (frame in cachedFrames) {
            if (frame > time - 1.0) {
                count++;
            }
        }

        text = "FPS: " + count;
        #else
        throw "Unsupported build target. Psyche doesn't support Web builds.";
        #end
    }
}