/**
 * Created by max.rozdobudko@gmail.com on 1/31/18.
 */
package com.github.airext.debug {
import com.github.airext.DeviceInfo;
import com.github.airext.core.device_info;

import flash.system.Capabilities;

use namespace device_info;

public class Debug {

    public static const shared: Debug = new Debug();

    public function Debug() {
        super()
    }

    public function startANRWatchdog(timeout: int = 5000): void {
        if (Capabilities.version.substr(0, 3).toUpperCase() == "AND") {
            DeviceInfo.context.call("debugStartANRWatchdog");
        }
    }
}
}
