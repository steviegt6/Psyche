package fnf.options;

import fnf.states.abstracts.AbstractOptionsState;
#if desktop
import fnf.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import fnf.Controls;

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
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end

		super.create();

		ClientPrefs.saveSettings();
	}

	override function closeSubState()
	{
		super.closeSubState();

		ClientPrefs.saveSettings();
	}
}
