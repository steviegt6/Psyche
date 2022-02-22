package fnf.psyche.eventbus;

import fnf.psyche.eventbus.DependencyContext;

/**
    An event bus dedicated to supplying dependencies.
**/
class DependencyInjector {
    private var injectors:Array<DependencyContext -> Void> = [];

    public function new() {
    }

    public function getDependency<T>(context:DependencyContext):T {
        for (listener in injectors) {
            listener(context);
        }

        return context.getCurrentValue();
    }

    public function listen(listener:DependencyContext -> Void) {
        injectors.push(listener);
    }
}