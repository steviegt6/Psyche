package fnf.psyche.eventbus;

import fnf.psyche.content.Identifier;

/**
	Provides context used to resolve dependencies in a `DependencyInjector`.
**/
class DependencyContext
{
	/**
		A unique identifier for this context.
	**/
	public var id(default, null):Identifier;

	/**
		The original value that will be used if `value` is null.
	**/
	public var original(default, null):Dynamic;

	/**
		The dependency context's value.
	**/
	public var value:Null<Dynamic>;

    /**
        Returns `original` if `original` is not `null`, otherwise `value`.
    **/
	public function getCurrentValue():Dynamic
	{
		return original == null ? value : original;
	}
}
