/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/3/13
 * Time: 6:07 PM
 * To change this template use File | Settings | File Templates.
 */
package com.github.airext
{
import com.github.airext.core.device_info;
import com.github.airext.data.DeviceInfoBattery;
import com.github.airext.data.DeviceInfoGeneral;

import flash.events.StatusEvent;

import flash.external.ExtensionContext;
import flash.net.registerClassAlias;
import flash.system.Capabilities;

use namespace device_info;

public class DeviceInfo
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    device_info static const EXTENSION_ID:String = "com.github.airext.DeviceInfo";

    //--------------------------------------------------------------------------
    //
    //  Class properties
    //
    //--------------------------------------------------------------------------

    private static var _context:ExtensionContext;

    device_info static function get context():ExtensionContext
    {
        if (_context == null)
        {
            _context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
        }

        return _context;
    }

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static function isSupported():Boolean
    {
        return context != null && context.call("isSupported");
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
    //  Static initialization
    //
    //--------------------------------------------------------------------------

    {
        registerClassAlias("com.github.airext.data.DeviceInfoGeneral", DeviceInfoGeneral);
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

    private var _imei:String;

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

    private var _general:DeviceInfoGeneral;

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

    private var _battery:DeviceInfoBattery;

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

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function getGeneral():DeviceInfoGeneral
    {
        return context.call("getGeneralInfo") as DeviceInfoGeneral;
    }

    public function getBattery():DeviceInfoBattery
    {
        return new DeviceInfoBattery();
    }

    public function getIMEI():String
    {
        return context.call("getIMEI") as String;
    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    private function statusHandler(event:StatusEvent):void
    {

    }
}
}
