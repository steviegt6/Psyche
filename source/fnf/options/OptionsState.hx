package fnf.options;

import flash.text.TextField;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;
import fnf.Controls;
import fnf.DiscordClient;
import fnf.states.abstracts.AbstractOptionsState;
import haxe.Json;
import lime.utils.Assets;

using StringTools;

class OptionsState extends AbstractOptionsState
{
	function getOptions():Array<String>
	{
		return [
			'Note Colors',
			'Controls',
			'Adjust Delay and Combo',
			'Graphics',
			'Visuals and UI',
			'Gameplay'
		];
	}

	function openSelectedSubstate(label:String)
	{
		switch (label)
		{
			case 'Note Colors':
				openSubState(new fnf.options.NotesSubState());

			case 'Controls':
				openSubState(new fnf.options.ControlsSubState());

			case 'Graphics':
				openSubState(new fnf.options.GraphicsSettingsSubState());

			case 'Visuals and UI':
				openSubState(new fnf.options.VisualsUISubState());

			case 'Gameplay':
				openSubState(new fnf.options.GameplaySettingsSubState());

			case 'Adjust Delay and Combo':
				LoadingState.loadAndSwitchState(new fnf.options.NoteOffsetState());
		}
	}

	override function handleGoBack()
	{
		FlxG.sound.play(Paths.sound('cancelMenu'));
		MusicBeatState.switchState(new MainMenuState());
	}

	override function create()
	{
		DiscordClient.changePresence("Options Menu", null);

		super.create();

		ClientPrefs.saveSettings();
	}

	override function closeSubState()
	{
		super.closeSubState();

		ClientPrefs.saveSettings();
	}
}
