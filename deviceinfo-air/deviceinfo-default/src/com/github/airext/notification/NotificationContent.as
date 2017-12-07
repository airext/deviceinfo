/**
 * Created by max.rozdobudko@gmail.com on 12/3/17.
 */
package com.github.airext.notification {
import flash.system.Capabilities;

public class NotificationContent {

    public function NotificationContent() {
        super();
    }

    public var title: String;
    public var body: String;
    public var userInfo: Object;

    public function userInfoAsJSON(): String {
        trace("DeviceInfo is not supported for " + Capabilities.os);
        return JSON.stringify(userInfo);
    }

    public function toString(): String {
        return '[NotificationContent(title="'+title+'", body="'+body+'", userInfo="'+userInfo+'")]';
    }
}
}
