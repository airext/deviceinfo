/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/3/13
 * Time: 6:37 PM
 * To change this template use File | Settings | File Templates.
 */
package com.github.airext
{
import com.github.airext.appearance.StatusBar;
import com.github.airext.deviceinfo.DeviceInfoBattery;
import com.github.airext.deviceinfo.DeviceInfoGeneral;

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

    public static function sharedInstance():DeviceInfo
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
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  imei
    //-------------------------------------

    /** @private */
    private var _imei:String;

    /**
     * Returns IMEI if supporte, or <code>null</code> otherwise.
     */
    public function get imei():String
    {
        if (_imei == null)
        {
            _imei = getIMEI();
        }

        return _imei;
    }

    //-------------------------------------
    //  general
    //-------------------------------------

    /** @private */
    private var _general:DeviceInfoGeneral;

    /**
     * Provides access for DeviceInfoGeneral object that describes device's
     * general info.
     */
    public function get general():DeviceInfoGeneral
    {
        if (_general == null)
        {
            _general = getGeneral();
        }

        return _general;
    }

    //-------------------------------------
    //  battery
    //-------------------------------------

    /** @private */
    private var _battery:DeviceInfoBattery;

    /**
     * Provides access for DeviceInfoBattery object that describes Battery state.
     */
    public function get battery():DeviceInfoBattery
    {
        if (_battery == null)
        {
            _battery = getBattery();
        }

        return _battery;
    }

    //-------------------------------------
    //  network
    //-------------------------------------

    //-------------------------------------
    //  display
    //-------------------------------------

    //-------------------------------------
    //  statusBar
    //-------------------------------------

    /** @private */
    private var _statusBar:StatusBar;

    /**
     * Provides access to system Status Bar
     */
    public function get statusBar():StatusBar
    {
        if (_statusBar == null)
        {
            _statusBar = getStatusBar();
        }

        return _statusBar;
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

    public function getGeneral():DeviceInfoGeneral
    {
        trace("DeviceInfo is not supported for " + Capabilities.os);

        return new DeviceInfoGeneral();
    }

    public function getBattery():DeviceInfoBattery
    {
        trace("DeviceInfo is not supported for " + Capabilities.os);

        return new DeviceInfoBattery();
    }

    public function getStatusBar():StatusBar
    {
        trace("DeviceInfo is not supported for " + Capabilities.os);

        return new StatusBar();
    }

    public function log():void
    {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }

    public function crash():void
    {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }
}
}
