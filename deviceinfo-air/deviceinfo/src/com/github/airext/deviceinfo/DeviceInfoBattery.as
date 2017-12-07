/**
 * Created by mobitile on 10/22/14.
 */
package com.github.airext.deviceinfo
{
import com.github.airext.DeviceInfo;
import com.github.airext.core.device_info;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.StatusEvent;

use namespace device_info;

public class DeviceInfoBattery extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function DeviceInfoBattery()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  level
    //------------------------------------

    private var _level:Number;

    [Bindable(event="batteryLevelChange")]
    public function get level():Number
    {
        if (isNaN(_level))
        {
             _level = getLevel();
        }

        return _level;
    }

    private function setLevel(value:Number):void
    {
        if (value == _level) return;
        _level = value;
        dispatchEvent(new DeviceInfoBatteryEvent(DeviceInfoBatteryEvent.BATTERY_LEVEL_CHANGE));
    }

    //------------------------------------
    //  state
    //------------------------------------

    private var _state:String;

    [Bindable(event="batteryStateChange")]
    public function get state():String
    {
        if (_state == null)
        {
            _state = getState();
        }

        return _state;
    }

    private function setState(value:String):void
    {
        if (value == _state) return;
        _state = value;
        dispatchEvent(new DeviceInfoBatteryEvent(DeviceInfoBatteryEvent.BATTERY_STATE_CHANGE));
    }

    //------------------------------------
    //  isMonitoring
    //------------------------------------

    private var _isMonitoring:Boolean = false;

    [Bindable(event="isMonitoringChanged")]
    public function get isMonitoring():Boolean
    {
        return _isMonitoring;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function getLevel():Number
    {
        return DeviceInfo.context.call("getBatteryLevel") as Number;
    }

    public function getState():String
    {
        return DeviceInfo.context.call("getBatteryState") as String;
    }

    public function startMonitoring():void
    {
        if (!_isMonitoring)
        {
            DeviceInfo.context.addEventListener(StatusEvent.STATUS, statusHandler);

            DeviceInfo.context.call("startBatteryMonitor");

            _isMonitoring = true;

            dispatchEvent(new Event("isMonitoringChanged"));
        }
    }

    public function stopMonitoring():void
    {
        if (_isMonitoring)
        {
            DeviceInfo.context.removeEventListener(StatusEvent.STATUS, statusHandler);

            DeviceInfo.context.call("stopBatteryMonitor");

            _isMonitoring = false;

            dispatchEvent(new Event("isMonitoringChanged"));
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override public function toString():String
    {
        return '[DeviceInfoBattery level="'+_level+'", state="'+_state+'"]';
    }

    //--------------------------------------------------------------------------
    //
    //  Event handler
    //
    //--------------------------------------------------------------------------

    private function statusHandler(event:StatusEvent):void
    {
        switch (event.code)
        {
            case "DeviceInfo.Battery.State.Change" :

                setState(event.level);

                break;

            case "DeviceInfo.Battery.Level.Change" :

                setLevel(parseFloat(event.level));

                break;
        }
    }

}
}
