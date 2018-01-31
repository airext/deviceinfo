/**
 * Created by max.rozdobudko@gmail.com on 1/31/18.
 */
package com.github.airext.debug {
import flash.system.Capabilities;

public class Debug {

    public static const shared: Debug = new Debug();

    public function Debug() {
        super()
    }

    public function startANRWatchdog(timeout: int = 5000): void {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }
}
}
