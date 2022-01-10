# Fast & Furious Presents: Kellog’s: Final the Official Psyche To-Do List of Back-Burner Throways All-Stars 2: Electron Boogaloo: Return of the Jedi & Knuckles - Featuring Dante From the Devil May Cry Series (Requires a Nintendo WI-FI Connection) [Parental Advistory - Explicit Content]; Only for the Gameboy Color.

To see specific details, scroll down to individual headers which detail plans.

* Package refactoring.
* EventBus and dependency injection-driven code.
* Object-oriented design philosophy with a data-driven approach when possible
* Extensive codebase refactoring.
* Revamped asset system.
* Haxe Hotloading

# Package Refactoring
Everything should preferably be in the base "`fnf`" package, and then receive further organization from there. This helps with understanding the code base.

# EventBusses, Dependency Injection, and You
EventBusses are a great way to remove hard-coded and messy conditionals and the such. Instead, you can simply subscribe to an EventBus which will dispatch events to you when applicable. This lets you entirely avoid every having to touch any code directly, and lets you work from a mod environment while still being able to manipulate practically anything.

Alongside EventBusses are dependency injection, which will be heaviliy facilitated for your own objects. This lets you create your own usable implementations of what would normally be standard FNF objects.

# OOP Philosophy
Currently, FNF is *very* OOP, but not in the good way. This is basically an extension of EventBusses and Dep. Injection. OOP is a wonderful thing, but only if done well.

**This mainly serves as a reminder for me, ignore this.**

# Codebase Refactoring
Current code sucks balls, refactor, clean up, and document everything.

# Asset System
The new asset system is cool, but it won't play nice with my plans for mod loading. I'll need to revamp it and give each mod its very own asset repository that it can use, which will be capable of queueing files for loading, and hopefully permit spectacular loading screends - and then some.

# Haxe Hotloading
I hate Lua. I just do. Hotloading Haxe through mods is a much more capable approach, and will allow me to move the base FNF game to its very own mod as well, hopefully decoupling things as much as possible!