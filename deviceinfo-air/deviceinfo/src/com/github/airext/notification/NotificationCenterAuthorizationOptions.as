/**
 * Created by max.rozdobudko@gmail.com on 12/10/17.
 */
package com.github.airext.notification {
public class NotificationCenterAuthorizationOptions {

    public static var badge: NotificationCenterAuthorizationOptions = new NotificationCenterAuthorizationOptions(1 << 0);
    public static var sound: NotificationCenterAuthorizationOptions = new NotificationCenterAuthorizationOptions(1 << 1);
    public static var alert: NotificationCenterAuthorizationOptions = new NotificationCenterAuthorizationOptions(1 << 2);

    public function NotificationCenterAuthorizationOptions(rawValue: int) {
        super();
        _rawValue = rawValue;
    }

    private var _rawValue: int;
    public function get rawValue(): int {
        return _rawValue;
    }
}
}
