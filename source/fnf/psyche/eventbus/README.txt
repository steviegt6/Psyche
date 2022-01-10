The EventBus system provides a method of globalized communication between objects.

There are three components:
* The event.
* The event listener (function).
* The event bus.

The event is a simple object that is dispatched to all event listeners, which modify the event as they see fit.

The event bus caches all listeners and handles event dispatching.