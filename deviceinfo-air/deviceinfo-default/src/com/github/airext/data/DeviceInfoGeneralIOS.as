/**
 * Created by mobitile on 10/22/14.
 */
package com.github.airext.data
{
import flash.system.Capabilities;

public class DeviceInfoGeneralIOS
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DeviceInfoGeneralIOS()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function getVendorIdentifier():String
    {
        trace("DeviceInfo is not supported for " + Capabilities.os);

        return null;
    }
}
}
