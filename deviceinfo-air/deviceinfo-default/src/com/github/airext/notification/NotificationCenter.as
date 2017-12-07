/**
 * Created by max.rozdobudko@gmail.com on 12/3/17.
 */
package com.github.airext.notification {
import com.github.airext.core.device_info;

import flash.events.EventDispatcher;
import flash.system.Capabilities;

use namespace device_info;

public class NotificationCenter extends EventDispatcher {

    public static function get isSupported(): Boolean {
        return false;
    }

    public static function get isEnabled(): Boolean {
        trace("DeviceInfo is not supported for " + Capabilities.os);
        return false;
    }

    public static function get canOpenSettings(): Boolean {
        trace("DeviceInfo is not supported for " + Capabilities.os);
        return false;
    }

    public static function openSettings(): void {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }

    public static function get permissionStatus(): String {
        trace("DeviceInfo is not supported for " + Capabilities.os);
        return null;
    }

    private static var _current: NotificationCenter;
    public static function get current(): NotificationCenter {
        if (_current == null) {
            _current = new NotificationCenter();
        }
        return _current;
    }

    public function NotificationCenter() {
        super();
    }

    public function requestPermission(callback: Function): void {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }

    public function add(request: NotificationRequest, callback: Function): void {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }

    public function removePendingNotificationRequests(identifiers: Vector.<int>): void {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }

    public function removeAllPendingNotificationRequests(): void {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }

    device_info function inForeground(): void {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }

    device_info function inBackground(): void {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }
}
}
