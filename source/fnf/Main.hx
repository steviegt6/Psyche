package fnf;

import flixel.FlxGame;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import fnf.psyche.Psyche;
import fnf.psyche.api.EnvPopulator;
import fnf.psyche.api.PsycheIdentifiers;
import fnf.psyche.content.Identifier;
import fnf.psyche.eventbus.DependencyContext;
import interpret.Env;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import openfl.text.TextField;

class Main extends Sprite
{
	public static var gameWidth:Int; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	public static var gameHeight:Int; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	public static var initialState:Class<FlxState>; // The FlxState the game starts with.
	public static var zoom:Float; // If -1, zoom is automatically calculated to fit the window dimensions.
	public static var framerate:Int; // How many frames per second the game should run at.
	public static var skipSplash:Bool; // Whether to skip the flixel splash screen that appears in release mode.
	public static var startFullscreen:Bool; // Whether to start the game in fullscreen on desktop targets.
	public static var fpsVar:TextField; // The FPS display to use.

	// You can pretty much ignore everything from here on - your code should go in your states.
	public static function main():Void
	{
		var env = new Env();
		EnvPopulator.populate(env);
		Psyche.load(env);

		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		gameWidth = Psyche.getDependency(PsycheIdentifiers.GAME_WIDTH, 1280);
		gameHeight = Psyche.getDependency(PsycheIdentifiers.GAME_HEIGHT, 720);
		initialState = Psyche.getDependency(PsycheIdentifiers.GAME_INITIAL_STATE, TitleState);
		zoom = Psyche.getDependency(PsycheIdentifiers.GAME_ZOOM, -1);
		framerate = Psyche.getDependency(PsycheIdentifiers.GAME_FRAMERATE, 60);
		skipSplash = Psyche.getDependency(PsycheIdentifiers.GAME_SKIP_SPLASH, true);
		startFullscreen = Psyche.getDependency(PsycheIdentifiers.GAME_START_FULLSCREEN, false);
		fpsVar = Psyche.getDependency(PsycheIdentifiers.GAME_FPS_DISPLAY, new FPS(10, 3, 0xFFFFFF));
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		#if !debug
		initialState = TitleState;
		#end

		ClientPrefs.loadDefaultKeys();
		// fuck you, persistent caching stays ON during sex
		FlxGraphic.defaultPersist = true;
		// the reason for this is we're going to be handling our own cache smartly
		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
		addChild(fpsVar);

		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

		if (fpsVar != null)
		{
			fpsVar.visible = ClientPrefs.showFPS;
		}
	}
}
