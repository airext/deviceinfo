/**
 * Created by max.rozdobudko@gmail.com on 12/3/17.
 */
package com.github.airext.data {
import com.github.airext.DeviceInfo;
import com.github.airext.bridge.bridge;
import com.github.airext.core.device_info;
import com.github.airext.events.NotificationCenterEvent;

import flash.desktop.NativeApplication;
import flash.events.Event;

import flash.events.EventDispatcher;

import flash.events.StatusEvent;

import flash.permissions.PermissionStatus;

import skein.utils.delay.delayToTimeout;

use namespace device_info;

public class DeviceInfoNotificationCenter extends EventDispatcher {

    public static function get isSupported(): Boolean {
        if (DeviceInfo.isSupported()) {
            return DeviceInfo.context.call("notificationCenterIsSupported");
        } else {
            return false;
        }
    }

    public static function get permissionStatus(): String {
        return DeviceInfo.context.call("notificationCenterPermissionStatus") as String;
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

        NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, activateHandler);
        NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, deactivateHandler);

        DeviceInfo.context.addEventListener(StatusEvent.STATUS, statusHandler);

        delayToTimeout(30, function (): void {
            inForeground();
        });
    }

    public function requestPermission(callback: Function): void {
        bridge(DeviceInfo.context).call("notificationCenterRequestPermission").callback(function (error: Error, value: Object): void {
            if (error) {
                callback(PermissionStatus.UNKNOWN);
            } else {
                callback(value as String);
            }
        });
    }

    // Sending Notifications

    public function add(request: DeviceInfoNotificationRequest, callback: Function): void {
        bridge(DeviceInfo.context).call("notificationCenterAddRequest", request).callback(function (error: Error, value: Object): void {
            callback(error);
        });
    }

    public function removePendingNotificationRequests(identifiers: Vector.<int>): void {
        DeviceInfo.context.call("notificationCenterRemovePendingNotificationRequests", identifiers);
    }

    public function removeAllPendingNotificationRequests(): void {
        DeviceInfo.context.call("notificationCenterRemoveAllPendingNotificationRequests");
    }

    // Work with background

    device_info function inForeground(): void {
        DeviceInfo.context.call("notificationCenterInForeground");
    }

    device_info function inBackground(): void {
        DeviceInfo.context.call("notificationCenterInBackground");
    }

    //  StatusEvent handler

    private function statusHandler(event:StatusEvent):void {
        switch (event.code) {
            case "DeviceInfo.NotificationCenter.Data.Receive" :
                    var params: Object = null;
                    try {
                        params = JSON.parse(event.level);
                    } catch (e: Error) {
                        params = event.level;
                    }
                    dispatchEvent(new NotificationCenterEvent(NotificationCenterEvent.NOTIFICATION_RECEIVED, false, false, params));
                break;
        }
    }

    // NativeApplication handlers

    private function deactivateHandler(event: Event): void {
        inBackground();
    }

    private function activateHandler(event: Event): void {
        inForeground();
    }
}
}
