/**
 * Created by mobitile on 10/23/14.
 */
package com.github.airext.deviceinfo
{
import flash.events.Event;

public class DeviceInfoBatteryEvent extends Event
{
    public static const BATTERY_LEVEL_CHANGE:String = "batteryLevelChange";
    public static const BATTERY_STATE_CHANGE:String = "batteryStateChange";

    public function DeviceInfoBatteryEvent(type: String) {
        super(type);
    }
}
}
