/**
 * Created by max.rozdobudko@gmail.com on 3/11/18.
 */
package com.github.airext.deviceinfo.data {
import flash.net.registerClassAlias;

public class EdgeInsets {

    // Static initialization

    {
        registerClassAlias("com.github.airext.deviceinfo.data.EdgeInsets", EdgeInsets);
    }

    // Constructor

    public function EdgeInsets(top: Number, left: Number, bottom: Number, right: Number) {
        super();
        _top = top;
        _left = left;
        _bottom = bottom;
        _right = right;
    }

    // top

    private var _top: Number;
    public function get top(): Number {
        return _top;
    }

    // left

    private var _left: Number;
    public function get left(): Number {
        return _left;
    }

    // bottom

    private var _bottom: Number;
    public function get bottom(): Number {
        return _bottom;
    }

    // right

    private var _right: Number;
    public function get right(): Number {
        return _right;
    }

    // Description

    public function toString(): String {
        return "[EdgeInsets(top: "+top+", left: "+left+", bottom: "+bottom+", right: "+right+")]";
    }
}
}
