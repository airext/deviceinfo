/**
 * Created by mobitile on 10/22/14.
 */
package com.github.airext.data
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
    //  Variables
    //
    //--------------------------------------------------------------------------

    private var isMonitoring:Boolean = false;

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //------------------------------------
    //  level
    //------------------------------------

    private var _level:Number;

    [Bindable(event="levelChanged")]
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
        dispatchEvent(new Event("levelChanged"));
    }

    //------------------------------------
    //  state
    //------------------------------------

    private var _state:String;

    [Bindable(event="stateChanged")]
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
        dispatchEvent(new Event("stateChanged"));
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
        if (!isMonitoring)
        {
            DeviceInfo.context.addEventListener(StatusEvent.STATUS, statusHandler);

            DeviceInfo.context.call("startBatteryMonitor");

            isMonitoring = true;
        }
    }

    public function stopMonitoring():void
    {
        if (isMonitoring)
        {
            DeviceInfo.context.removeEventListener(StatusEvent.STATUS, statusHandler);

            DeviceInfo.context.call("stopBatteryMonitor");

            isMonitoring = false;
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
