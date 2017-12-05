/**
 * Created by max.rozdobudko@gmail.com on 12/3/17.
 */
package com.github.airext.data {
import com.github.airext.core.device_info;

import flash.events.EventDispatcher;

use namespace device_info;

public class DeviceInfoNotificationCenter extends EventDispatcher {

    public static function get isSupported(): Boolean {
        return false;
    }

    public static function get permissionStatus(): String {
        return null;
    }

    private static var _current: DeviceInfoNotificationCenter;
    public static function get current(): DeviceInfoNotificationCenter {
        if (_current == null) {
            _current = new DeviceInfoNotificationCenter();
        }
        return _current;
    }

    public function DeviceInfoNotificationCenter() {
        super();
    }

    public function requestPermission(callback: Function): void {
    }

    public function add(request: DeviceInfoNotificationRequest, callback: Function): void {
    }

    public function removePendingNotificationRequests(identifiers: Vector.<int>): void {
    }

    public function removeAllPendingNotificationRequests(): void {
    }
}
}
