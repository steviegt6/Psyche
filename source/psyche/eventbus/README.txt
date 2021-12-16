The EventBus system provides a method of globalized communication between objects.

There are three components:
* The event.
* The event listener.
* The event handler.

The event is a simple object that distributes data globally, and is reference by all listeners/handlers.
class MyEvent extends Event {
    public var myField:String = ""; // can be accessed with ease
}

The listener is an interface that lets handlers implement a method to handle events that get dispatched.
interface IMyEventListener extends IEventListener {
    function onMyEvent(event:MyEvent):Void; // should always return void
}

The handler is the fully-featured class which handles dispatched events.
class MyEventHandler implements IMyEventListener {
    public function onMyEvent(event:MyEvent):Void { // implement the function from IMyEventListener
        event.myField = "Hello, world!"; // modifies a variable, yay
    }
}

These are united through an object known as an EventBus, which handles event dispatching and collects classes.
You could handle events using something such as this:
function foobar():Void {
    var bus:EventBus = new EventBus();
    var event:MyEvent = new MyEvent();

    // register the EventHandler so the EventBus can acknowledge it
    bus.registerEventHandler(new MyEventHandler()); // this could be done from the MyEventHandler class with a static instance

    // if the EventBus has registered any EventHandlers with handle an event of this type, the event will be dispatched
    bus.dispatchEvent(event);

    trace(event.myField); // would print "Hello, world!" if the example above was implemented
}