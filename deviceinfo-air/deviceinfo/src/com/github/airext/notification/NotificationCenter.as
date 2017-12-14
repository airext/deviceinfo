/**
 * Created by max.rozdobudko@gmail.com on 12/3/17.
 */
package com.github.airext.notification {
import com.github.airext.DeviceInfo;
import com.github.airext.bridge.bridge;
import com.github.airext.core.device_info;

import flash.desktop.NativeApplication;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.permissions.PermissionStatus;

import skein.utils.delay.delayToTimeout;

use namespace device_info;

public class NotificationCenter extends EventDispatcher {

    // Availability & Permissions

    public static function get isSupported(): Boolean {
        if (DeviceInfo.isSupported()) {
            trace("NotificationCenter.isSupported");
            return DeviceInfo.context.call("notificationCenterIsSupported");
        } else {
            return false;
        }
    }

    public static function get isEnabled(): Boolean {
        trace("NotificationCenter.isEnabled");
        return DeviceInfo.context.call("notificationCenterIsEnabled");
    }

    public static function get canOpenSettings(): Boolean {
        trace("NotificationCenter.canOpenSettings");
        return DeviceInfo.context.call("notificationCenterCanOpenSettings");
    }

    public static function openSettings(): void {
        trace("NotificationCenter.openSettings");
        DeviceInfo.context.call("notificationCenterOpenSettings");
    }

    public static function requestAuthorizationWithOptions(options: int, completion: Function): void {
        trace("NotificationCenter.requestAuthorizationWithCompletion");
        bridge(DeviceInfo.context).call("notificationCenterRequestAuthorization", options).callback(function (error: Error, value: Object): void {
            if (error) {
                if (completion.length == 2) {
                    completion(PermissionStatus.UNKNOWN, error);
                } else {
                    completion(PermissionStatus.UNKNOWN);
                }
            } else {
                completion(value as String);
            }
        });
    }

    public static function getNotificationSettingsWithCompletion(handler: Function): void {
        bridge(DeviceInfo.context).call("notificationCenterGetNotificationSettings").callback(function (error: Error, value: Object): void {
            if (error) {
                if (handler.length == 2) {
                    handler(null, error);
                } else {
                    handler(null);
                }
            } else {
                handler(value);
            }
        });
    }

    // Shared instance

    private static var _current: NotificationCenter;
    public static function get current(): NotificationCenter {
        if (_current == null) {
            _current = new NotificationCenter();
        }
        return _current;
    }

    // Constructor

    public function NotificationCenter() {
        super();

        NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, activateHandler);
        NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, deactivateHandler);

        DeviceInfo.context.addEventListener(StatusEvent.STATUS, statusHandler);

        delayToTimeout(30, function (): void {
            inForeground();
        });
    }

    // Sending Notifications

    public function add(request: NotificationRequest, callback: Function): void {
        trace("NotificationCenter", "adding notification request");
        bridge(DeviceInfo.context).call("notificationCenterAddRequest", request).callback(function (error: Error, value: Object): void {
            callback(error);
        });
        trace("NotificationCenter", "notification request added");
    }

    public function removePendingNotificationRequests(identifiers: Vector.<int>): void {
        trace("NotificationCenter.removePendingNotificationRequests");
        DeviceInfo.context.call("notificationCenterRemovePendingNotificationRequests", identifiers);
    }

    public function removeAllPendingNotificationRequests(): void {
        trace("NotificationCenter.notificationCenterRemoveAllPendingNotificationRequests");
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
