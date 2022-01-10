# Psyche
_Psyche_ is a fork of [_Pysche Engine_](https://github.com/ShadowMario/FNF-PsychEngine) with polished and more consistent code, as well as safer multi-OS compiliation and an expanded featureset.

_Pysche_ is intended to work as a layer above _Psyche Engine_, keeping backwards-compatibility while adding new features and functionality for modders and players.

#### Planned Features
* Haxe hot-loading --- no more do you have to deal with Lua's limitations!
* Event-based system allowing for easy modifications to be applied to almost anything (needs to be manually implemented, will take time).
* A polished, optimized code-base; enjoy the pros without the cons.
* Genuine documentation --- what's a GitHub wiki?

#### Why a fork? Why not just make a pull request?
I've been waiting nearly two months for a pull request as simple as one that changes a couple compilation flags (see: ShadowMario/FNF-PsychEngine#700). I do not want to endure Shadow Mario's PR process. In addition to that, I also have my own design philosophies and nitpicks (some of which are not compatible with Shadow Mario's), and am less tolerant of 9-year-olds on my repositories.

### Psych Engine
The engine originally used as a base for the [Mind Games Mod](https://gamebanana.com/mods/301107), intended to be a fix for the vanilla version's many issues while keeping the casual play aspect of it. Also aiming to be an easier modding alternative for those that are unfamiliar with Haxe.

## Building:
You must have [the most up-to-date version of Haxe](https://haxe.org/download/). Stop using 4.1.5, no support will be offered.

<!-- TODO: Abolish this God-forsaken library!! -->
Follow a Friday Night Funkin' source code compilation tutorial, after this you will need to install LuaJIT.

LuaJIT can be installed by running `haxelib install linc_luajit` in your favorite terminal.

<!-- TODO: Conditionals, pl0x -->
...Or if you don't want your mod to be able to run .lua scripts, delete the "LUA_ALLOWED" line on Project.xml

## Psyche Credits:
* Tomat - I know where you sleep at night.

### Psych Engine Credits:
* Shadow Mario - Coding
* RiverOaken - Arts and Animations
* bbpanzu - Assistant Coding

### Psych Engine Special Thanks
* shubs - New Input System
* SqirraRNG - Chart Editor's Sound Waveform base code
* iFlicky - Delay/Combo Menu Song Composer + Dialogue Sounds
* PolybiusProxy - .MP4 Loader Extension
* Keoiki - Note Splash Animations
* Smokey - Spritemap Texture Atlas support
_____________________________________

# Psyche Features
Original _Psyche Engine_ features can be find below.

# Psych Engine Features

## Attractive animated dialogue boxes:
![](https://user-images.githubusercontent.com/44785097/127706669-71cd5cdb-5c2a-4ecc-871b-98a276ae8070.gif)


## Mod Support (Lua)
* The engine's main attraction; `.lua` files are compiled at runtime and can be freely distributed without modification of the source code.
* Comes with a menu for organizing, enabling, and disabling mods. 


## At Least One Change to Every Vanilla Week:
### Week 1:
  * Daddy Dearest's left sing sprite has been updated.
  * Previously-unused stage light textures are now used.

### Week 2:
  * Boyfriend and Skid & Pump both have "Hey!" animations.
  * When lightning strikes, a quick light flashes and zooms the camera in slightly.
  * Added a quick transition/cutscene to Monster.

### Week 3:
  * Boyfriend has a "Hey!" animation during Philly Nice.
  * The climax of Blammed flashes different colors.

### Week 4:
  * Improved hair physics for Mommy Mearest and Boyfriend.
  * Henchmen will die during all songs.

### Week 5:
  * Bottom Boppers and Girlfriend do "Hey!" animations during Cocoa and Eggnog.
  * On Winter Horrorland, Girlfriend bops her head slower in some parts of the song to adjust for changed rhythm.

### Week 6:
  * On Thorns, the HUD is hidden during the cutscene.
  * The Background Girls switch to their "spooky" sprites during the "Hey!" parts of the instrumental.

## Cool New Chart Editor Changes and Countless Bug Fixes
![](https://github.com/ShadowMario/FNF-PsychEngine/blob/main/docs/img/chart.png?raw=true)
* You can now chart "Event" notes, which are bookmarks that trigger specific actions that were typically hardcoded in vanilla.
* Your song's BPM can now have decimal values.
* You can manually adjust a Note's strum time if you're really going for milisecond precision.
* You can change a note's type in the editor. It comes with two example types:
  * Alt Animation: Forces an alt animation to play, useful for songs like Ugh/Stress.
  * Hey: Forces a "Hey" animation instead of the base Sing animation, if Boyfriend hits this note, Girlfriend will do a "Hey!" too.

## Multiple Editors to Assist You in Making Your Own Mod
![Screenshot_3](https://user-images.githubusercontent.com/44785097/144629914-1fe55999-2f18-4cc1-bc70-afe616d74ae5.png)
* Works both for Source code modding and Downloaded builds!

## Story Mode Menu Rework:
![](https://i.imgur.com/UB2EKpV.png)
* Added a different background to every song (save for Tutorial).
* All menu characters are now in individual spritesheets, makes modifications easier.

## Credits Menu
![Screenshot_1](https://user-images.githubusercontent.com/44785097/144632635-f263fb22-b879-4d6b-96d6-865e9562b907.png)
* You can add a head icon, name, description and a redirect link for when the player presses Enter while the item is currently selected.

## Awards/Achievements
* The engine comes with sixteen example achievements that you can mess with to understand their functionality (check `Achievements.hx` and search for `checkForAchievement` in `PlayState.hx`).

## Options Menu:
* You can change note colors, delay and combo offset, controls and preferences there.
 * In the "Preferences" menu, you can toggle downscroll, middlescroll, anti-aliasing, framerate, low-quality sprites, note splashes, flashing lights, and more.

## Other Gameplay Features:
* When the enemy hits a note, their strum note also glows.
* Lag doesn't impact the camera movement and player icon scaling anymore.
* Some stuff based on Week 7's changes have been clean-room backported (background colors on freeplay, note splashes)
* You can reset your score on freeplay/story mode by pressing the reset button.
* You can listen to a song or adjust Scroll speed/damage taken/etc. on freeplay by pressing space.
