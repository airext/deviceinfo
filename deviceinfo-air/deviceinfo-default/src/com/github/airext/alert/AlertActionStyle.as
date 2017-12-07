/**
 * Created by max.rozdobudko@gmail.com on 12/2/17.
 */
package com.github.airext.alert {
public class AlertActionStyle {

    public static const normal: AlertActionStyle        = new AlertActionStyle(0);
    public static const destructive: AlertActionStyle   = new AlertActionStyle(1);
    public static const cancellation: AlertActionStyle  = new AlertActionStyle(2);

    public function AlertActionStyle(rawValue: int) {
        super();
        _rawValue = rawValue;
    }

    private var _rawValue: int;
    public function get rawValue(): int {
        return _rawValue;
    }
}
}
