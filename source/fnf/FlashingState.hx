package fnf;

import fnf.states.abstracts.AbstractOptionsState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import fnf.psyche.PsycheUtils;

class FlashingState extends AbstractOptionsState
{
	public static var leftState:Bool = false;

    /**
        Get the selectable options for this state.
    **/
    function getOptions():Array<String> {
		return ['Disable Lights', 'Keep Lights Enabled', 'Ask On Startup'];
	}

    /**
        Handle selected options, labels will match strings from `getOptions`.
    **/
	function openSelectedSubstate(label:String):Void {
		if (leftState)
			return;

		leftState = true;
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;

		switch (label)
		{
			case 'Disable Lights':
				ClientPrefs.flashing = false;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxFlicker.flicker(warnText, 1, 0.1, false, true, function(flk:FlxFlicker) {
					new FlxTimer().start(0.5, function (tmr:FlxTimer) {
						MusicBeatState.switchState(new TitleState());
					});
				});

			case 'Keep Lights Enabled':
				ClientPrefs.flashing = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new TitleState());
					}
				});

			case 'Ask On Startup':
				ClientPrefs.flashingSet = false;
				ClientPrefs.flashing = true;
				FlxFlicker.flicker(warnText, 1, 0.1, false, true, function(flk:FlxFlicker) {
					new FlxTimer().start(0.5, function (tmr:FlxTimer) {
						MusicBeatState.switchState(new TitleState());
					});
				});
		}

		ClientPrefs.saveSettings();
	}

	override function getBackground() {
		return new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
	}

	override function getYOffset() {
		return 100;
	}

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var warnTextDisplay:Array<String> = [
			"Hey, watch out!",
			"Psyche contains flashing lights",
			"which could induce seizures.",
			"While it is not common, epileptic",
			"seizures can be caused by strobing."
		];

		warnText = new FlxText(0, 0, FlxG.width, PsycheUtils.combineStrings(warnTextDisplay, "\n"), 32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		warnText.y -= 150;
		add(warnText);
	}
}
