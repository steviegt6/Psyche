package fnf.psyche;

import openfl.text.TextFormat;
import openfl.text.TextField;

class PsycheFpsDisplay extends TextField {
    private var recentTimes:Array<FpsCache> = [];
    private var totalTime:Float;

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
        var roundedFps:String = "Rounded FPS: ";
        var realFps:String = "Real FPS: ";

        // keep track of total lifetime
        totalTime += deltaTime;

        // find the fps (0.0005 added to correct for rounded delta time)
        var calculatedFps:Int = Math.round(1 / ((deltaTime / 1000) + 0.0005));

        // add calculated fps to the realfps display
        realFps += calculatedFps;

        // add to the average fps cache array
        recentTimes.push(new FpsCache(calculatedFps, totalTime));

        // cull array (eliminate fps records more than a second old)
        while (recentTimes[0].time < totalTime - 1000)
        {
            recentTimes.shift();
        }
    
        // calculate the average fps
        var roundableFps:Float = 0;
    
        for (time in recentTimes) {
            roundableFps += time.fps;
        }
    
        roundableFps /= recentTimes.length;
        roundedFps += Math.round(roundableFps);

        // display rounded and real fps
        text = roundedFps + "\n" + realFps;
    }
}

class FpsCache {
    public var fps:Float;
    public var time:Float;

    public function new(fps:Float, time:Float) {
        this.fps = fps;
        this.time = time;
    }
}