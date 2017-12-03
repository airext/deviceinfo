/**
 * Created by max.rozdobudko@gmail.com on 12/2/17.
 */
package com.github.airext.data {
import com.github.airext.DeviceInfo;
import com.github.airext.bridge.bridge;
import com.github.airext.bridge.core.Call;
import com.github.airext.core.device_info;
import com.github.airext.enum.DeviceInfoAlertStyle;

use namespace device_info;

public class DeviceInfoAlert {

    // Constructor

    public function DeviceInfoAlert(title: String, message: String, preferredStyle: DeviceInfoAlertStyle) {
        super();
        _title = title;
        _message = message;
        _preferredStyle = preferredStyle;
    }

    // title

    private var _title: String;
    public function get title(): String {
        return _title;
    }
    public function set title(value: String): void {
        _title = value;
    }

    // message

    private var _message: String;
    public function get message(): String {
        return _message;
    }
    public function set message(value: String): void {
        _message = value;
    }

    // preferredStyle

    private var _preferredStyle: DeviceInfoAlertStyle;
    public function get preferredStyle(): DeviceInfoAlertStyle {
        return _preferredStyle;
    }

    // Actions

    private var _actions: Vector.<DeviceInfoAlertAction> = new <DeviceInfoAlertAction>[];
    public function get actions(): Vector.<DeviceInfoAlertAction> {
        return _actions;
    }

    private var _preferredAction: DeviceInfoAlertAction;
    public function get preferredAction(): DeviceInfoAlertAction {
        return _preferredAction;
    }
    public function set preferredAction(action: DeviceInfoAlertAction): void {
        addActionIfNotExists(action);
        _preferredAction = action;
    }

    public function addAction(action: DeviceInfoAlertAction): void {
        addActionIfNotExists(action);
    }
    protected function addActionIfNotExists(action: DeviceInfoAlertAction): void {
        if (_actions.indexOf(action) == -1) {
            _actions[_actions.length] = action;
        }
    }

    // Presentation

    private var _call: Call;

    public function present(): void {
        if (_call != null) {
            trace("[deviceinfo] Attempt to present DeviceInfoAlert that is already presented.");
            return;
        }

        _call = bridge(DeviceInfo.context).call("presentAlert", _title, _message, _preferredStyle, _actions);
        _call.callback(function (error: Error, value: Object): void {
            if (value is int) {
                var actionIndex: int = value as int;
                if (actionIndex >= 0 && actionIndex < _actions.length) {
                    _actions[actionIndex].notify();
                }
            }
            _call = null;
        });
    }

    public function dismiss(): void {
        DeviceInfo.context.call("dismissAlert", _call.id);
        _call = null;
    }
}
}
