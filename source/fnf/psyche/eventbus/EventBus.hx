package fnf.psyche.eventbus;

using Std;

/**
    A simple object capable of dispatching events to event listeners.
**/
class EventBus {
    private var map:Map<String, Array<Dynamic -> Void>> = [];

    public function new() {
    }

    public function dispatch(event:Event, eventClass:Class<Event>):Void {
        if (!map.exists(Type.getClassName(eventClass))) {
            return;
        }

        for (listener in map[Type.getClassName(eventClass)]) {
            listener(event);
        }
    }

    public function listen(eventClass:Class<Event>, listener:Dynamic -> Void) {
        if (!map.exists(Type.getClassName(eventClass))) {
            map[Type.getClassName(eventClass)] = [];
        }

        map[Type.getClassName(eventClass)].push(listener);
    }
}