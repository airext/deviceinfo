/**
 * Created by max.rozdobudko@gmail.com on 3/21/17.
 */
package com.github.airext.appearance
{
import com.github.airext.DeviceInfo;
import com.github.airext.core.device_info;

import flash.events.EventDispatcher;

use namespace device_info;

public class StatusBar extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function StatusBar()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function setStyle(style:String):void
    {
        DeviceInfo.context.call("setStatusBarStyle", style);
    }

    public function getStyle():String
    {
        return DeviceInfo.context.call("getStatusBarStyle") as String;
    }
}
}
