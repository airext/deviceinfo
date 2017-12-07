/**
 * Created by max.rozdobudko@gmail.com on 12/7/17.
 */
package com.github.airext.appearance {
import com.github.airext.DeviceInfo;
import com.github.airext.core.device_info;

use namespace device_info;

public class ThemeAndroid {

    // Constructor

    public function ThemeAndroid() {
        super();
    }

    private var _style: ThemeAndroidStyle = ThemeAndroidStyle.NoShadow;
    public function get style(): ThemeAndroidStyle {
        return _style;
    }
    public function set style(value: ThemeAndroidStyle): void {
        _style = value;
        DeviceInfo.context.call("themeSetStyle", value);
    }
}
}
