package fnf.psyche.api;

import fnf.psyche.content.Identifier;

/**
 * Holds all the constant `fnf.psyche.content.Identifier`s used in the base engine.
 */
class PsycheIdentifiers
{
	/**
	 * Determines the game window's width.
	 * 
	 * Type: `Int`
	 */
	public static final GAME_WIDTH = create("game_width");

	/**
	 * Determines the game window's height.
	 * 
	 * Type: `Int`
	 */
	public static final GAME_HEIGHT = create("game_height");

	/**
	 * Determines the game's inital state.
	 * 
	 * Type: `FlxState`
	 */
	public static final GAME_INITIAL_STATE = create("game_initial_state");

	/**
	 * Determine's the game's zoomf factor.
	 * 
	 * Type: `Float`
	 */
	public static final GAME_ZOOM = create("game_zoom");

	/**
	 * Determines the game's framerate.
	 * 
	 * Type: `Int`
	 */
	public static final GAME_FRAMERATE = create("game_framerate");

	/**
	 * Determines whether the HaxeFlixel jumpscare should be skipped.
	 * 
	 * Type: `Bool`
	 */
	public static final GAME_SKIP_SPLASH = create("game_skip_splash");

	/**
	 * Determines whether the game should start in fullscreen.
	 * 
	 * Type: `Bool`
	 */
	public static final GAME_START_FULLSCREEN = create("game_start_fullscreen");

	/**
	 * The `TextField` to display as an FPS counter.
	 * 
	 * Type: `TextField`
	 */
	public static final GAME_FPS_DISPLAY = create("game_fps_display");

	static function create(content:String):Identifier
	{
		return new Identifier("psyche", content);
	}
}
