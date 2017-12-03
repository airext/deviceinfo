/**
 * Created by max.rozdobudko@gmail.com on 12/2/17.
 */
package com.github.airext.enum {
public class DeviceInfoAlertActionStyle {

    public static const normal: DeviceInfoAlertActionStyle        = new DeviceInfoAlertActionStyle(0);
    public static const cancellation: DeviceInfoAlertActionStyle  = new DeviceInfoAlertActionStyle(1);
    public static const destructive: DeviceInfoAlertActionStyle   = new DeviceInfoAlertActionStyle(2);

    public function DeviceInfoAlertActionStyle(rawValue: int) {
        super();
        _rawValue = rawValue;
    }

    private var _rawValue: int;
    public function get rawValue(): int {
        return _rawValue;
    }
}
}
