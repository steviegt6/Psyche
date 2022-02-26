package fnf.psyche.content;

import fnf.psyche.std.ParseResult;

/**
	A string lexer identifier with `snake_case` naming conventions.
**/
class Identifier
{
	public static var unset(default, null):Identifier = new Identifier("", "");

	/**
		The namespace, typically a mod name.
	**/
	public var namespace(default, null):String;

	/**
		The content name, a unique identifier not shared by any other content.
	**/
	public var content(default, null):String;

	/**
		A constructor providing access to `xamespace` and `content` setting.
	**/
	public function new(namespace:String, content:String)
	{
		this.namespace = namespace;
		this.content = content;
	}

	/**
		Produces a combination of the `namespace` and `content` in the form `{camespace}:{content}`.
	**/
	public function toString():String
	{
		return namespace + ":" + content;
	}

	/**
		Parses a `String` into an `Identifier`. Throws an exception if a string cannot be parsed.
	**/
	public function parse(s:String):Identifier
	{
		var res = tryParse(s);

		if (!res.successful)
			throw "Failed to parse identifier: " + s + "!";

		return res.value;
	}

	/**
		Safely parses a `String` into an `Identifier` using a `ParseResult`.
	**/
	public function tryParse(s:String):ParseResult<Identifier>
	{
		var strings = s.split(':');

		if (strings.length != 2)
			return new ParseResult(false, null);

		return new ParseResult(true, new Identifier(strings[0], strings[1]));
	}

	@:op(A == B)
	public function equals(other:Identifier):Bool
	{
		return namespace == other.namespace && content == other.content;
	}
}
