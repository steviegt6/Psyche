package fnf.states.abstracts;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

/**
	Provides basic functionality for rendering menus with selectable text.
**/
abstract class AbstractOptionsState extends MusicBeatState
{
	private var grpOptions:FlxTypedGroup<Alphabet>;

	public var curSelected:Int = 0;
	public var menuBG:FlxSprite;

	public var selectorLeft:Alphabet;
	public var selectorRight:Alphabet;

	/**
		Get the selectable options for this state.
	**/
	abstract function getOptions():Array<String>;

	/**
		Handle selected options, labels will match strings from `getOptions`.
	**/
	abstract function openSelectedSubstate(label:String):Void;

	/**
		Not required; a function that handles going back to the previous menu.
	**/
	public function handleGoBack()
	{
	}

	public function getYOffset():Int
	{
		return 0;
	}

	public function getBackground()
	{
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0xFFea71fd;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		return bg;
	}

	override function create()
	{
		/*#if desktop
			DiscordClient.changePresence("Options Menu", null);
			#end */

		add(getBackground());

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		var options:Array<String> = getOptions();

		// TODO: Add hooks.
		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true, false);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50 + getYOffset();
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '>', true, false);
		add(selectorLeft);

		selectorRight = new Alphabet(0, 0, '<', true, false);
		add(selectorRight);

		changeSelection();

		// ClientPrefs.saveSettings();

		super.create();
	}

	/*override function closeSubState() {
		super.closeSubState();

		// ClientPrefs.saveSettings();
	}*/
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UI_UP_P)
		{
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			handleGoBack();
		}

		if (controls.ACCEPT)
		{
			var options:Array<String> = getOptions();
			trace(options[curSelected]);
			openSelectedSubstate(options[curSelected]);
		}
	}

	function changeSelection(change:Int = 0)
	{
		var options:Array<String> = getOptions();

		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0)
			{
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}
