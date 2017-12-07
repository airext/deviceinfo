/**
 * Created by max.rozdobudko@gmail.com on 12/2/17.
 */
package com.github.airext.alert {
import com.github.airext.core.device_info;

import flash.system.Capabilities;

use namespace device_info;

public class Alert {

    // Constructor

    public function Alert(title: String, message: String, preferredStyle: AlertStyle) {
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

    private var _preferredStyle: AlertStyle;
    public function get preferredStyle(): AlertStyle {
        return _preferredStyle;
    }

    // Actions

    private var _actions: Vector.<AlertAction> = new <AlertAction>[];
    public function get actions(): Vector.<AlertAction> {
        return _actions;
    }

    private var _preferredAction: AlertAction;
    public function get preferredAction(): AlertAction {
        return _preferredAction;
    }
    public function set preferredAction(action: AlertAction): void {
        addActionIfNotExists(action);
        _preferredAction = action;
    }

    public function addAction(action: AlertAction): void {
        addActionIfNotExists(action);
    }
    protected function addActionIfNotExists(action: AlertAction): void {
        if (_actions.indexOf(action) == -1) {
            _actions[_actions.length] = action;
        }
    }

    // Presentation

    public function present(): void {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }

    public function dismiss(): void {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }
}
}
