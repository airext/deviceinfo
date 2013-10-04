/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/3/13
 * Time: 6:37 PM
 * To change this template use File | Settings | File Templates.
 */
package com.github.rozd.ane
{
import flash.system.Capabilities;

public class DeviceInfo
{
    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static function isSupported():Boolean
    {
        return false;
    }

    private static var instance:DeviceInfo;

    public static function getInstance():DeviceInfo
    {
        if (instance == null)
        {
            instance = new DeviceInfo();
        }

        return instance;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DeviceInfo()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function getIMEI():String
    {
        trace("DeviceInfo is not supported for " + Capabilities.os);

        return null;
    }

    public function getDeviceInfo():Object
    {
        trace("DeviceInfo is not supported for " + Capabilities.os);

        return null;
    }
}
}
