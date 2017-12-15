/**
 * Created by max.rozdobudko@gmail.com on 12/15/17.
 */
package com.github.airext.vibration {
import com.github.airext.DeviceInfo;
import com.github.airext.core.device_info;

use namespace device_info;

public class Vibration {

    public static function vibrate(duration: int): void {
        DeviceInfo.context.call("vibrate", duration);
    }
    
    public function Vibration() {
        super();
    }
}
}
