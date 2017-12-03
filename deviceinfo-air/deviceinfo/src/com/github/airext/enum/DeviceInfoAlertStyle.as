/**
 * Created by max.rozdobudko@gmail.com on 12/2/17.
 */
package com.github.airext.enum {
public class DeviceInfoAlertStyle {

    public static const actionSheet: DeviceInfoAlertStyle = new DeviceInfoAlertStyle(0);
    public static const alert: DeviceInfoAlertStyle       = new DeviceInfoAlertStyle(1);

    public function DeviceInfoAlertStyle(rawValue: int) {
        super();
        _rawValue = rawValue;
    }

    private var _rawValue: int;
    public function get rawValue(): int {
        return _rawValue;
    }
}
}
