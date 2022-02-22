package fnf.psyche;

import fnf.psyche.content.Identifier;
import fnf.psyche.eventbus.DependencyContext;
import fnf.psyche.eventbus.DependencyInjector;
import fnf.psyche.eventbus.events.tests.TitleScreenCreateTestEvent;
import fnf.psyche.eventbus.EventBus;

class Psyche
{
	public static var PEInjector:DependencyInjector = new DependencyInjector();
	public static var PEBus:EventBus = new EventBus();

	public static function registerPsycheEvents():Void
	{
		PEInjector.listen((context) -> handleInjections(context));

		PEBus.listen(TitleScreenCreateTestEvent, (event) ->
		{
			trace("[TEST] Hello from EventBus land!");
		});
	}

	private static function handleInjections(context:DependencyContext):Void
	{
		if (context.id.toString() == "psyche:fps")
		{
			trace("HI");
			context.value = new PsycheFpsDisplay(10, 3);
		}
	}
}
