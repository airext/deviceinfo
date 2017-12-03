/**
 * Created by max.rozdobudko@gmail.com on 12/2/17.
 */
package com.github.airext.data {
import com.github.airext.core.device_info;
import com.github.airext.enum.DeviceInfoAlertActionStyle;

public class DeviceInfoAlertAction {

    public function DeviceInfoAlertAction(title: String, style: DeviceInfoAlertActionStyle, handler: Function = null) {
        super();
        _title = title;
        _style = style;
        _handler = handler;
    }

    private var _title: String;
    public function get title(): String {
        return _title;
    }

    private var _style: DeviceInfoAlertActionStyle;
    public function get style(): DeviceInfoAlertActionStyle {
        return _style;
    }

    private var _isEnabled: Boolean = true;
    public function get isEnabled(): Boolean {
        return _isEnabled;
    }
    public function set isEnabled(value: Boolean): void {
        _isEnabled = value;
    }

    private var _handler: Function;
    public function get handler(): Function {
        return _handler;
    }

    device_info function notify(): void {
        if (_handler != null) {
            if (_handler.length == 1) {
                _handler(this);
            } else {
                _handler();
            }
        }
    }

    public function toString(): String {
        return _title;
    }
}
}
