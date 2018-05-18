/**
 * Created with IntelliJ IDEA.
 * User: mobitile
 * Date: 10/3/13
 * Time: 6:07 PM
 * To change this template use File | Settings | File Templates.
 */
package com.github.airext
{
import com.github.airext.appearance.StatusBar;
import com.github.airext.core.device_info;
import com.github.airext.deviceinfo.DeviceInfoBattery;
import com.github.airext.deviceinfo.DeviceInfoGeneral;
import com.github.airext.deviceinfo.DeviceInfoScreen;

import flash.desktop.NativeApplication;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.registerClassAlias;

use namespace device_info;

public class DeviceInfo {

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

    device_info static function get context():ExtensionContext {
        if (_context == null) {
            _context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
        }

        return _context;
    }

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    /**
     * Indicates if DeviceInfo extension is supported on current platform.
     *
     * @return <code>true</code> if DeviceInfo is supported or <code>false</code>
     * otherwise.
     */
    public static function get isSupported():Boolean {
        return context != null && context.call("isSupported");
    }

    //-------------------------------------
    //  sharedInstance
    //-------------------------------------

    /** @private */
    private static var instance:DeviceInfo;

    /**
     * Provides acces for shared instance of DeviceInfo object.
     *
     * @return
     */
    public static function get sharedInstance(): DeviceInfo {
        if (instance == null) {
            instance = new DeviceInfo();
        }

        return instance;
    }

    //-------------------------------------
    //  extensionVersion
    //-------------------------------------

    private static var _extensionVersion:String = null;

    /**
     * Returns version of extension
     * @return extension version
     */
    public static function extensionVersion():String {
        if (_extensionVersion == null) {
            try {
                var extension_xml:File = ExtensionContext.getExtensionDirectory(EXTENSION_ID).resolvePath("META-INF/ANE/extension.xml");
                if (extension_xml.exists) {
                    var stream:FileStream = new FileStream();
                    stream.open(extension_xml, FileMode.READ);

                    var extension:XML = new XML(stream.readUTFBytes(stream.bytesAvailable));
                    stream.close();

                    var ns:Namespace = extension.namespace();

                    _extensionVersion = extension.ns::versionNumber;
                }
            } catch (error:Error) {
                // ignore
            }
        }

        return _extensionVersion;
    }

    //--------------------------------------------------------------------------
    //
    //  Static initialization
    //
    //--------------------------------------------------------------------------

    {
        registerClassAlias("com.github.airext.deviceinfo.DeviceInfoGeneral", DeviceInfoGeneral);
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DeviceInfo() {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Information API
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
    public function get imei():String {
        if (_imei == null) {
            _imei = getIMEI();
        }

        return _imei;
    }

    /**
     * Returns IMEI if supported.
     *
     * @return actual IMEI on Android, or <code>null</code> on iOS
     */
    public function getIMEI():String {
        return context.call("getIMEI") as String;
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
    public function get general():DeviceInfoGeneral {
        if (_general == null) {
            _general = getGeneral();
        }

        return _general;
    }

    /**
     * Gathers general info and returns it as DeviceInfoGeneral object.
     *
     * @return Instance of DeviceInfoGeneral class.
     */
    public function getGeneral():DeviceInfoGeneral {
        return context.call("getGeneralInfo") as DeviceInfoGeneral;
    }

    //-------------------------------------
    //  battery
    //-------------------------------------

    /** @private */
    private var _battery:DeviceInfoBattery;

    /**
     * Provides access to DeviceInfoBattery object that describes Battery state.
     */
    public function get battery():DeviceInfoBattery {
        if (_battery == null) {
            _battery = getBattery();
        }

        return _battery;
    }

    /**
     * Gathers Battery's info and returns it as DeviceInfoBattery object.
     *
     * @return Instance of DeviceInfoBattery class.
     */
    public function getBattery():DeviceInfoBattery {
        return new DeviceInfoBattery();
    }

    //-------------------------------------
    //  network
    //-------------------------------------

    //-------------------------------------
    //  screen
    //-------------------------------------

    private var _screen: DeviceInfoScreen;
    public function get screen(): DeviceInfoScreen {
        if (_screen == null) {
            _screen = new DeviceInfoScreen();
        }
        return _screen;
    }

    public function getScreen(): DeviceInfoScreen {
        return new DeviceInfoScreen();
    }

    //-------------------------------------
    //  statusBar
    //-------------------------------------

    /** @private */
    private var _statusBar:StatusBar;

    /**
     * Provides access to system Status Bar
     */
    public function get statusBar():StatusBar {
        if (_statusBar == null) {
            _statusBar = getStatusBar();
        }

        return _statusBar;
    }

    /**
     * Returns proxy class for working with system Status Bar
     *
     * @return Instance of StatusBar class.
     */
    public function getStatusBar():StatusBar {
        return new StatusBar();
    }

    //-------------------------------------
    //  openSettings
    //-------------------------------------

    public function openSettings(): void {
        context.call("openSettings");
    }

    //--------------------------------------------------------------------------
    //
    //  Special API
    //
    //--------------------------------------------------------------------------

    /**
     * Logs specified message through NSLog on iOS and Log.w on Android. Could
     * take one or two params:
     *
     * <code>DeviceInfo.sharedInstance().log("Logging message");</code>
     * or
     * <code>DeviceInfo.sharedInstance().log("TAG", "Logging message");</code>
     * if TAG is not specified the Application's id will used. TAG is always
     * ignored on iOS.
     *
     * @param args TAG and/or logging message.
     */
    public function log(...args):void {
        var params:Array = ["log"];

        switch (args.length) {
            case 0 :
                params.concat(NativeApplication.nativeApplication.applicationID);
                params.concat("");
                break;

            case 1 :
                params = params.concat(NativeApplication.nativeApplication.applicationID);
                params = params.concat(args);
                break;

            default :
                params = params.concat(args);
                break;
        }

        context.call.apply(null, params);
    }

    /**
     * Simulates out-of-range run time error.
     */
    public function crash():void {
        context.call("crash");
    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    private function statusHandler(event:StatusEvent):void {

    }
}
}
