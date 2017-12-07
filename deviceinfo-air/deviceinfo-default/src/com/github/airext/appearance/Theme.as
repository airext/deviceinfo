/**
 * Created by max.rozdobudko@gmail.com on 12/7/17.
 */
package com.github.airext.appearance {
import com.github.airext.DeviceInfo;
import com.github.airext.core.device_info;

import flash.system.Capabilities;

use namespace device_info;

public class Theme {

    public static function get isSupported(): Boolean {
        return false;
    }

    private static var _shared: Theme;
    public static function get shared(): Theme {
        if (_shared == null) {
            _shared = new Theme();
        }
        return _shared;
    }

    private static var _platformCode: String;
    private static function get platformCode(): String {
        if (_platformCode == null) {
            _platformCode = Capabilities.version.substr(0, 3).toUpperCase();
        }
        return _platformCode;
    }

    public function Theme() {
        super();
    }

    private var _style: ThemeStyle;
    public function get style(): ThemeStyle {
        return _style;
    }
    public function set style(value: ThemeStyle): void {
        _style = value;
    }

    private var _android: ThemeAndroid;
    public function get android(): ThemeAndroid {
        if (_android == null) {
            _android = new ThemeAndroid();
        }
        return _android;
    }
}
}
