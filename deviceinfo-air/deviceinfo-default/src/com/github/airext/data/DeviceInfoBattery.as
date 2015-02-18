/**
 * Created by mobitile on 10/22/14.
 */
package com.github.airext.data
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.system.Capabilities;

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
        trace("DeviceInfo is not supported for " + Capabilities.os);

        return null;
    }

    public function getState():String
    {
        trace("DeviceInfo is not supported for " + Capabilities.os);

        return null;
    }

    public function startMonitoring():void
    {
        trace("DeviceInfo is not supported for " + Capabilities.os);
    }

    public function stopMonitoring():void
    {
        trace("DeviceInfo is not supported for " + Capabilities.os);
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
}
}
