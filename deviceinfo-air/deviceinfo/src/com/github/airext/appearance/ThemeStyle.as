/**
 * Created by max.rozdobudko@gmail.com on 12/7/17.
 */
package com.github.airext.appearance {
public class ThemeStyle {

    public static const Light: ThemeStyle = new ThemeStyle("light");
    public static const Dark: ThemeStyle  = new ThemeStyle("dark");

    public function ThemeStyle(rawValue: String) {
        super();
        _rawValue = rawValue;
    }

    private var _rawValue: String;
    public function get rawValue(): String {
        return _rawValue;
    }
}
}
