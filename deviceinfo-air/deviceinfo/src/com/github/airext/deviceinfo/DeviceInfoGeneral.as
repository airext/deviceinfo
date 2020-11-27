/**
 * Created by mobitile on 10/22/14.
 */
package com.github.airext.deviceinfo
{
import com.github.airext.core.device_info;
import com.github.airext.utils.SystemUtil;

use namespace device_info;

public class DeviceInfoGeneral
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DeviceInfoGeneral() {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  name
    //-------------------------------------

    public var name:String;

    //-------------------------------------
    //  model
    //-------------------------------------

    public var model:String;

    //-------------------------------------
    //  manufacturer
    //-------------------------------------

    public var manufacturer:String;

    //-------------------------------------
    //  systemName
    //-------------------------------------

    public var systemName:String;

    //-------------------------------------
    //  systemVersion
    //-------------------------------------

    public var systemVersion:String;

    //-------------------------------------
    //  platform
    //-------------------------------------

    public var platform:String;

    //--------------------------------------------------------------------------
    //
    //  Platform-specific properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  ios
    //-------------------------------------

    private var _ios:DeviceInfoGeneralIOS;
    public function get ios():DeviceInfoGeneralIOS {
        if (!SystemUtil.isIOS) {
            return null;
        }
        if (_ios == null) {
            _ios = new DeviceInfoGeneralIOS();
        }

        return _ios;
    }

    //-------------------------------------
    //  android
    //-------------------------------------

    private var _android:DeviceInfoGeneralAndroid;
    public function get android():DeviceInfoGeneralAndroid {
        if (!SystemUtil.isAndroid) {
            return null;
        }
        if (_android == null) {
            _android = new DeviceInfoGeneralAndroid();
        }

        return _android;
    }

    //-------------------------------------
    //  osx
    //-------------------------------------

    //-------------------------------------
    //  win
    //-------------------------------------

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function toString():String
    {
        return '[DeviceInfoGeneral ' +
               'name="'+name+'", ' +
               'model="'+model+'", ' +
               'manufacturer="'+manufacturer+', ' +
               'systemName="'+systemName+'", ' +
               'systemVersion="'+systemVersion+'", ' +
               'ios="'+ios+'",' +
               'android="'+android+'",' +
                ']';
    }
}
}
