/**
 * Created by max.rozdobudko@gmail.com on 12/3/17.
 */
package com.github.airext.data {
public class DeviceInfoTimeIntervalNotificationTrigger extends DeviceInfoNotificationTrigger {

    public function DeviceInfoTimeIntervalNotificationTrigger(timeInterval: Number, repeats: Boolean = false) {
        super(repeats);

        _timeInterval = timeInterval;
    }

    private var _timeInterval: Number;
    public function get timeInterval(): Number {
        return _timeInterval;
    }
}
}
