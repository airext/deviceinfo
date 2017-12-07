/**
 * Created by mobitile on 10/23/14.
 */
package com.github.airext.deviceinfo
{
import flash.system.Capabilities;

public class DeviceInfoGeneralAndroid
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DeviceInfoGeneralAndroid()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function getAndroidIdentifier():String
    {
        trace("DeviceInfo is not supported for " + Capabilities.os);

        return null;
    }
}
}
