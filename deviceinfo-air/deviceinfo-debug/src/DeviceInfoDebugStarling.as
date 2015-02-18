package {

import com.github.airext.DeviceInfo;
import com.github.airext.data.DeviceInfoGeneral;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.text.TextField;

public class DeviceInfoDebugStarling extends Sprite
{
    public function DeviceInfoDebugStarling()
    {
        super();

        new PlainButton(this, "getIMEI", 0xFF0000, 0xFFFF00, {x: 100, y: 80, width : 200, height : 60},
            function clickHandler(event:Event):void
            {
                tf.text += "getting imei... \n";

                tf.text += "imei: " + DeviceInfo.sharedInstance().getIMEI() + "\n";
                trace(DeviceInfo.sharedInstance().getIMEI());
            }
        );

        new PlainButton(this, "getDeviceIdentifier", 0xFF0000, 0xFFFF00, {x: 100, y: 160, width : 200, height : 60},
            function clickHandler(event:Event):void
            {
                tf.text += "getting identifier... \n";

                tf.text += "getVendorIdentifier: " + DeviceInfo.sharedInstance().general.ios.getVendorIdentifier() + "\n";
                trace(DeviceInfo.sharedInstance().general.ios.getVendorIdentifier());
            }
        );

        new PlainButton(this, "getDeviceInfo", 0xFF0000, 0xFFFF00, {x: 100, y: 220, width : 200, height : 60},
            function clickHandler(event:Event):void
            {
                tf.text += "getting info... \n";

                var info:DeviceInfoGeneral = DeviceInfo.sharedInstance().general || {};

                tf.text += "name: " + info.name + "\n";
                tf.text += "model: " + info.model + "\n";
                tf.text += "manufacturer: " + info.manufacturer + "\n";
                tf.text += "systemName: " + info.systemName + "\n";
                tf.text += "systemVersion: " + info.systemVersion + "\n";

                trace("name:", info.name);
                trace("model:", info.model);
                trace("manufacturer:", info.manufacturer);
                trace("systemName:", info.systemName);
                trace("systemVersion:", info.systemVersion);
            }
        );

        var tf:TextField = new TextField();
        tf.border = true;
        tf.width = 600;
        tf.x = 20;
        tf.text = "Initializing...";
        tf.y = 240;
        addChild(tf);

        tf.text += "isSupported: " + DeviceInfo.isSupported() + "\n";

        addEventListener(Event.ADDED_TO_STAGE,
            function addedToStageHandler(event:Event):void
            {
                stage.scaleMode = StageScaleMode.NO_SCALE;
                stage.align = StageAlign.TOP_LEFT;
            }
        );
    }
}
}

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TouchEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

class PlainButton extends Sprite
{
    function PlainButton(parent:DisplayObjectContainer=null, label:String="", color:uint=0, textColor:uint=0xFFFFFF, properties:Object=null, clickHandler:Function=null)
    {
        super();

        _label = label;
        _color = color;
        _props = properties;

        textDisplay = new TextField();
        textDisplay.defaultTextFormat = new TextFormat("_sans", 24, textColor, null, null, null, null, null, TextFormatAlign.CENTER);
        textDisplay.selectable = false;
        textDisplay.autoSize = "center";
        addChild(textDisplay);

        x = _props.x || 0;
        y = _props.y || 0;

        if (parent)
            parent.addChild(this);

        if (clickHandler != null)
            addEventListener(MouseEvent.CLICK, clickHandler);

        sizeInvalid = true;
        labelInvalid = true;

        addEventListener(Event.ENTER_FRAME, renderHandler);
    }

    private var sizeInvalid:Boolean;
    private var labelInvalid:Boolean;

    private var _label:String;
    private var _color:uint;
    private var _props:Object;

    private var textDisplay:TextField;

    private function renderHandler(event:Event):void
    {
        if (labelInvalid)
        {
            labelInvalid = false;

            textDisplay.text = _label;
        }

        if (sizeInvalid)
        {
            sizeInvalid = false;

            var w:Number = _props.width || 0;
            var h:Number = _props.height || 0;

            graphics.clear();
            graphics.beginFill(_color);
            graphics.drawRect(0, 0, w, h);
            graphics.endFill();

            textDisplay.x = 0;
            textDisplay.width = w;
            textDisplay.y = (h - textDisplay.height) / 2;
        }
    }
}
