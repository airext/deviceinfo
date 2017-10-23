/**
 * Created by max.rozdobudko@gmail.com on 3/21/17.
 */
package com.github.airext.data
{
import com.github.airext.core.device_info;

import flash.events.EventDispatcher;
import flash.system.Capabilities;

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
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }

    public function getStyle():String
    {
        trace("DeviceInfo is not supported for " + Capabilities.os);

        return null;
    }
}
}
