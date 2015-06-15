/**
 * Created by mobitile on 10/23/14.
 */
package com.github.airext.data
{
import com.github.airext.DeviceInfo;
import com.github.airext.core.device_info;

use namespace device_info;

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
        return DeviceInfo.context.call("getAndroidIdentifier") as String;
    }
}
}
