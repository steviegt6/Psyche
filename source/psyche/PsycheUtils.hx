package psyche;

class PsycheUtils{
    public static function combineStrings(strings:Array<String>, separator:String):String{
        var string:String = "";

        for (i => str in strings) {
            string += str;

            if (i != strings.length - 1) {
                string += separator;
            }
        }

        return string;
    }
}