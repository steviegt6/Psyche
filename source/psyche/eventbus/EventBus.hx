package psyche.eventbus;

import haxe.Constraints.Function;

class EventBus {
    private var map:Map<Class<Dynamic>, EventInfo> = new Map<Class<Dynamic>, EventInfo>();

    public function new() {
    }

    private static function createEventInfo(eventListenerClass:Class<Dynamic>):EventInfo {
        var info:EventInfo = new EventInfo();

        info.eventListenerClass = eventListenerClass;

        var allFunctions:Array<Function> = [];

        for (field in Reflect.fields(eventListenerClass)) {
            if (field is Function) {
                allFunctions.push(cast field);
            }
        }

        if (allFunctions.length != 1) {
            throw "IEventListener " + Type.getClassName(eventListenerClass) + " must have a single function.";
        }

        info.eventFunction = allFunctions[0];

        return info;
    }
}