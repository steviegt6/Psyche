package fnf.psyche.std;

/**
	A simple class containing a boolean value indicating whether a prase was successful. Contains
**/
class ParseResult<T>
{
	/**
		Whether this parse was successuful.
	**/
	public var successful(default, null):Bool;

	/**
		A nullable parsed value. Will be `null` if `successful` is false, otherwise *should* contain a value.
	**/
	public var value(default, null):Null<T>;

	public function new(successful:Bool, value:Null<T>)
	{
		this.successful = successful;
		this.value = value;
	}
}
