/**
 * Created by max.rozdobudko@gmail.com on 12/3/17.
 */
package com.github.airext.notification {
public class TimeIntervalNotificationTrigger extends NotificationTrigger {

    public function TimeIntervalNotificationTrigger(timeInterval: Number, repeats: Boolean = false) {
        super(repeats);

        _timeInterval = timeInterval;
    }

    private var _timeInterval: Number;
    public function get timeInterval(): Number {
        return _timeInterval;
    }

    public function toString(): String {
        return '[TimeIntervalNotificationTrigger(timeInterval="'+timeInterval+'", repeats="'+repeats+'")]';
    }
}
}
