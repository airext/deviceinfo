/**
 * Created by max.rozdobudko@gmail.com on 12/15/17.
 */
package com.github.airext.vibration {
import com.github.airext.core.device_info;

import flash.system.Capabilities;

use namespace device_info;

public class Vibration {

    public static function vibrate(duration: int): void {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }
    
    public function Vibration() {
        super();
    }
}
}
