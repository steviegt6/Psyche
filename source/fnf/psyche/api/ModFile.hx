package fnf.psyche.api;

class ModFile
{
	/**
	 * Metadata information for a mod.
	 */
	public var metadata:ModMetadata;

	/**
	 * The base directory relative to `fnf.psyche.api.ModLoader.modDir`.
	 */
	public var directory:String;

	public function new()
	{
	}
}
