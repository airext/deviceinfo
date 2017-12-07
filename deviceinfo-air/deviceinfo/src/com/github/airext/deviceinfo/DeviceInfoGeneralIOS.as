/**
 * Created by mobitile on 10/22/14.
 */
package com.github.airext.deviceinfo
{
import com.github.airext.DeviceInfo;
import com.github.airext.core.device_info;

use namespace device_info;

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
        return DeviceInfo.context.call("iosGetVendorIdentifier") as String;
    }
}
}
