/**
 * Created by max.rozdobudko@gmail.com on 3/11/18.
 */
package com.github.airext.deviceinfo {
import com.github.airext.DeviceInfo;
import com.github.airext.core.device_info;
import com.github.airext.deviceinfo.data.EdgeInsets;

import flash.geom.Rectangle;
import flash.system.Capabilities;

use namespace device_info;

public class DeviceInfoScreen {

    // Constructor

    public function DeviceInfoScreen() {
        super();
    }

    // safeArea

    private var _safeArea: EdgeInsets;
    public function get safeArea(): EdgeInsets {
        if (_safeArea == null) {
            _safeArea = getSafeArea();
        }
        return _safeArea;
    }

    public function getSafeArea(): EdgeInsets {
        trace("DeviceInfo is not supported for " + Capabilities.os);
        return null;
    }
}
}
