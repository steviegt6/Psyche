package psyche.eventbus;

import haxe.Constraints.Function;

class EventInfo {
    public var eventClass:Class<Dynamic>;
    public var eventListenerClass:Class<Dynamic>;
    public var eventFunction:Function;
    public var listenerImplementations:List<IEventListener> = new List<IEventListener>();

    public function new() {
    }
}