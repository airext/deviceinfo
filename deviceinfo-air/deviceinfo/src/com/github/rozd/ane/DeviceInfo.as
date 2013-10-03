/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/3/13
 * Time: 6:07 PM
 * To change this template use File | Settings | File Templates.
 */
package com.github.rozd.ane
{
import com.github.rozd.ane.core.device_info;

import flash.events.StatusEvent;

import flash.external.ExtensionContext;

use namespace device_info;

public class DeviceInfo
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    device_info static const EXTENSION_ID:String = "com.github.rozd.ane.DeviceInfo";

    //--------------------------------------------------------------------------
    //
    //  Class properties
    //
    //--------------------------------------------------------------------------

    private static var _context:ExtensionContext;

    private static function get context():ExtensionContext
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

        context.addEventListener(StatusEvent.STATUS, statusHandler);
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

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
