/**
 * Created by max.rozdobudko@gmail.com on 12/3/17.
 */
package com.github.airext.notification {
public class NotificationRequest {

    // Constructor

    public function NotificationRequest(identifier: int, content: NotificationContent, trigger: NotificationTrigger) {
        super();

        _identifier = identifier;
        _content = content;
        _trigger = trigger;
    }

    private var _identifier: int;
    public function get identifier(): int {
        return _identifier;
    }

    private var _content: NotificationContent;
    public function get content(): NotificationContent {
        return _content;
    }

    private var _trigger: NotificationTrigger;
    public function get trigger(): NotificationTrigger {
        return _trigger;
    }

    public function toString(): String {
        return '[NotificationRequest(identifier="'+identifier+'", content="'+content+'", trigger="'+trigger+'")]';
    }
}
}
