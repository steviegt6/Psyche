package fnf.achievements;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxSpriteGroup;

class AttachedAchievement extends FlxSprite
{
	public var sprTracker:FlxSprite;

	private var tag:String;

	public function new(x:Float = 0, y:Float = 0, name:String)
	{
		super(x, y);

		changeAchievement(name);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function changeAchievement(tag:String)
	{
		this.tag = tag;
		reloadAchievementImage();
	}

	public function reloadAchievementImage()
	{
		if (Achievements.isAchievementUnlocked(tag))
		{
			var imagePath:FlxGraphic = Paths.image('achievementgrid');
			var isModIcon:Bool = false;

			if (Achievements.loadedAchievements.exists(tag))
			{
				isModIcon = true;
				imagePath = Paths.image(Achievements.loadedAchievements.get(tag).icon);
			}

			var index:Int = Achievements.getAchievementIndex(tag);
			if (isModIcon)
				index = 0;

			trace(imagePath);

			loadGraphic(imagePath, true, 150, 150);
			animation.add('icon', [index], 0, false, false);
			animation.play('icon');
		}
		else
		{
			loadGraphic(Paths.image('lockedachievement'));
		}
		scale.set(0.7, 0.7);
		updateHitbox();
	}

	override function update(elapsed:Float)
	{
		if (sprTracker != null)
			setPosition(sprTracker.x - 130, sprTracker.y + 25);

		super.update(elapsed);
	}
}
