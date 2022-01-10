package fnf.psyche;

import fnf.psyche.eventbus.events.tests.TitleScreenCreateTestEvent;
import fnf.psyche.eventbus.EventBus;

class Psyche {
    public static var PsycheEventBus:EventBus = new EventBus();

    public static function registerPsycheEvents():Void {
        PsycheEventBus.listen(TitleScreenCreateTestEvent, (event) -> {
            trace("[TEST] Hello from EventBus land!");
        });
    }
}