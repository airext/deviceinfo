/**
 * Created by max.rozdobudko@gmail.com on 12/3/17.
 */
package com.github.airext.notification {
public class NotificationTrigger {

    public function NotificationTrigger(repeats: Boolean = false) {
        super();
        _repeats = repeats;
    }

    private var _repeats: Boolean;
    public function get repeats(): Boolean {
        return _repeats;
    }
}
}
