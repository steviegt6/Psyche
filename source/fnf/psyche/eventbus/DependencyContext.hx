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

	public function new(id:Identifier, defVal:Dynamic)
	{
		this.id = id;
		this.original = defVal;
		this.value = null;
	}

	/**
		Returns `original` if `value` is `null`, otherwise `value`.
	**/
	public function getCurrentValue():Dynamic
	{
		return value == null ? original : value;
	}
}
