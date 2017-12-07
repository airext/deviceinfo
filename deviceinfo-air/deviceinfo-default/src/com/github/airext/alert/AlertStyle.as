/**
 * Created by max.rozdobudko@gmail.com on 12/2/17.
 */
package com.github.airext.alert {
public class AlertStyle {

    public static const alert: AlertStyle       = new AlertStyle(0);
    public static const actionSheet: AlertStyle = new AlertStyle(1);

    public function AlertStyle(rawValue: int) {
        super();
        _rawValue = rawValue;
    }

    private var _rawValue: int;
    public function get rawValue(): int {
        return _rawValue;
    }
}
}
