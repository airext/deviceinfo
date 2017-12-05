/**
 * Created by max.rozdobudko@gmail.com on 12/3/17.
 */
package com.github.airext.data {
public class DeviceInfoNotificationRequest {

    // Constructor

    public function DeviceInfoNotificationRequest(identifier: int, content: DeviceInfoNotificationContent, trigger: DeviceInfoNotificationTrigger) {
        super();

        _identifier = identifier;
        _content = content;
        _trigger = trigger;
    }

    private var _identifier: int;
    public function get identifier(): int {
        return _identifier;
    }

    private var _content: DeviceInfoNotificationContent;
    public function get content(): DeviceInfoNotificationContent {
        return _content;
    }

    private var _trigger: DeviceInfoNotificationTrigger;
    public function get trigger(): DeviceInfoNotificationTrigger {
        return _trigger;
    }
}
}
