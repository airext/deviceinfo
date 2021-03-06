/**
 * Created by mobitile on 10/22/14.
 */
package com.github.airext.deviceinfo
{
import flash.system.Capabilities;

public class DeviceInfoGeneralIOS {

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DeviceInfoGeneralIOS() {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  Methods: Platform Info
    //------------------------------------

    public function getVendorIdentifier():String {
        trace("DeviceInfo is not supported for " + Capabilities.os);
        return null;
    }

    //------------------------------------
    //  Methods: State preservation
    //------------------------------------

    public function ignoreSnapshotOnNextApplicationLaunch(): void {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }
}
}
