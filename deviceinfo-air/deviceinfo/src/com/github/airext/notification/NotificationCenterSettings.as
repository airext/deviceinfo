/**
 * Created by max.rozdobudko@gmail.com on 12/10/17.
 */
package com.github.airext.notification {
import flash.permissions.PermissionStatus;

public class NotificationCenterSettings {

    public function NotificationCenterSettings() {
        super();
    }

    private var _authorizationStatus: String;
    public function get authorizationStatus(): String {
        return _authorizationStatus;
    }
    public function set authorizationStatus(value: String): void {
        _authorizationStatus = value;
    }
}
}
