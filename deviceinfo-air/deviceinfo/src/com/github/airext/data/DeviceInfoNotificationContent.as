/**
 * Created by max.rozdobudko@gmail.com on 12/3/17.
 */
package com.github.airext.data {
public class DeviceInfoNotificationContent {

    public function DeviceInfoNotificationContent() {
        super();
    }

    public var title: String;
    public var body: String;
    public var userInfo: Object;

    public function userInfoAsJSON(): String {
        return JSON.stringify(userInfo);
    }
}
}
