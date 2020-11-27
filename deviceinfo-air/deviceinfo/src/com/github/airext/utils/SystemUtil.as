/**
 * Created by max.rozdobudko@gmail.com on 11/27/20.
 */
package com.github.airext.utils {
import flash.system.Capabilities;

public class SystemUtil {

    private static var _platform: String;

    {
        _platform = Capabilities.version.substr(0, 3);
    }

    public static function get isIOS(): Boolean {
        return _platform == "IOS";
    }

    public static function get isAndroid(): Boolean {
        return _platform == "AND";
    }
}
}
