package fnf.psyche.api;

import fnf.psyche.api.ModLoader.ModMetadata;

/**
 * A "file" containing a directory pointer as well as metadata.
 */
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

	public function new() {}
}
