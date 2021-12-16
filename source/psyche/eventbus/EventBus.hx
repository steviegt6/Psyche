package psyche.eventbus;

class EventBus {
    private var map:Map<Class<Dynamic>, List<Dynamic -> Void>> = new Map<Class<Dynamic>, List<Dynamic -> Void>>();

    public function new() {
    }

    public function dispatch(event:Event, eventClass:Class<Dynamic>):Void {
        if (!map.exists(eventClass)) {
            return;
        }

        for (listener in map[eventClass]) {
            listener(event);
        }
    }

    public function listen(eventClass:Class<Dynamic>, listener:Dynamic -> Void) {
        if (!map.exists(eventClass)) {
            map[eventClass] = new List<Dynamic -> Void>();
        }

        map[eventClass].push(listener);
    }
}