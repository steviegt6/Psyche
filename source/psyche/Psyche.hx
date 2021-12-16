package psyche;

import psyche.eventbus.events.tests.TitleScreenCreateTestEvent;
import psyche.eventbus.EventBus;

class Psyche {
    public static var PsycheEventBus:EventBus = new EventBus();

    public static function registerPsycheEvents():Void {
        PsycheEventBus.listen(TitleScreenCreateTestEvent, (event) -> {
            trace("[TEST] Hello from EventBus land!");
        });
    }
}