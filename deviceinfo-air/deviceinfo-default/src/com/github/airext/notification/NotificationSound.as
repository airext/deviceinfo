/**
 * Created by max.rozdobudko@gmail.com on 2/9/18.
 */
package com.github.airext.notification {
public class NotificationSound {

    // Constructor

    public function NotificationSound(named: String) {
        super();
        _named = named;
    }

    // named

    private var _named: String;
    public function get named(): String {
        return _named;
    }

    public function toString(): String {
        return "[NotificationSound(named='"+_named+"')]";
    }
}
}
