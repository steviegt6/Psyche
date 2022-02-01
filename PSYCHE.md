# Psyche TO-DOs & Plans

To see specific details, scroll down to individual headers which detail plans.

* Package refactoring.
* EventBus and dependency injection-driven code.
* Extensive codebase refactoring.
* Revamped asset system.
* Haxe Hotloading

# Package Refactoring
Everything should preferably be in the base "`fnf`" package, and then receive further organization from there. This helps with understanding the code base.

* ~~Move all relevant packages to the base `fnf` package.~~ Done.
* Further categorize packages. In progress.

# Event Busses, Dependency Injection, and You
The `EventBus` model is a great way to allow objecs (functions) to clearly communicate and modify incoming objects as needed. This opens up powerful, dynamic modding capabilities.

* ~~Implement an EventBus system.~~ Done.
* Modify existing code to accomodate the EventBus system. In progress.
* Incorporate dependency injection. Not started.

[Dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) is an OOP technique that allows a user to create more dynamic objects with less hard-coded components. This should be used alongside `EventBus`ses.

# Codebase Refactoring
Current code sucks balls, refactor, clean up, and document everything. Rewriting entire components may be required at times, and this should be done with `EventBus`ses in mind, for maximum capabilities. ModChart potential should also expand exponentially.

# Asset System
The new asset system is cool, but it won't play nice with my plans for mod loading. Hard-coded paths and weird, inconsistent directory searching is \*blegh\* as well. I'll need to revamp it and give each mod its very own asset repository that it can use, which will be capable of queueing files for loading, and hopefully permit spectacular loading screens and other fun stuff. Asynchrnous loading on a separate thread should also be investigated.

# Haxe Hotloading
I hate Lua. I just do. Hotloading Haxe through mods is a much more capable approach, and will allow me to move the base FNF game to its very own mod as well, hopefully decoupling things as much as possible!
