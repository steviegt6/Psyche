/**
    Contains miscellaneous constant values for use within projects, not necsesarily associated with FNF.
 **/
class Constants {
    public static var fnfVersion(default, null):String = "0.2.7.1";
    public static var psychEngineVersion(default, null):String = "0.5.1";

    // This field is never used internally - I have it here so people know where to actually look.
    // Consistency would dictate this field would be set here, but limitations with Lime makes it so I have to move it.
    /**
        This field is deprecated, please use `fnf.MainMenuState.psycheVersion` instead.
    **/
    @:deprecated
    public static var psycheVersion(default, null):String = "0.1.0";
}