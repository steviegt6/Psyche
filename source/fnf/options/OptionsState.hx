package fnf.options;

import flixel.FlxG;
import fnf.DiscordClient;
import fnf.states.abstracts.AbstractOptionsState;

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
