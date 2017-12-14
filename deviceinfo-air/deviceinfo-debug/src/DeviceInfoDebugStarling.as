package {

import com.github.airext.DeviceInfo;
import com.github.airext.alert.Alert;
import com.github.airext.alert.AlertAction;
import com.github.airext.alert.AlertActionStyle;
import com.github.airext.alert.AlertStyle;
import com.github.airext.appearance.Theme;
import com.github.airext.appearance.ThemeAndroidStyle;
import com.github.airext.appearance.ThemeStyle;
import com.github.airext.notification.NotificationCenter;
import com.github.airext.notification.NotificationCenterAuthorizationOptions;
import com.github.airext.notification.NotificationCenterEvent;
import com.github.airext.notification.NotificationCenterSettings;
import com.github.airext.notification.NotificationContent;
import com.github.airext.notification.NotificationRequest;
import com.github.airext.notification.TimeIntervalNotificationTrigger;

import flash.desktop.NativeApplication;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.InvokeEvent;
import flash.text.TextField;
import flash.utils.setTimeout;

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

                var info:Object = DeviceInfo.sharedInstance().general || {};

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

        new PlainButton(this, "hideStatusBar", 0xFF0000, 0xFFFF00, {x: 100, y: 280, width : 200, height : 60},
            function clickHandler(event:Event):void
            {
//                DeviceInfo.sharedInstance().statusBar.setHidden(true);
            }
        );

        new PlainButton(this, "showStatusBar", 0xFF0000, 0xFFFF00, {x: 100, y: 340, width : 200, height : 60},
            function clickHandler(event:Event):void
            {
//                DeviceInfo.sharedInstance().statusBar.setHidden(false);
            }
        );

        new PlainButton(this, "showAlert", 0xFF0000, 0xFFFF00, {x: 100, y: 400, width : 200, height : 60},
            function clickHandler(event:Event):void {
                showAlert("Info", "Hi");
            }
        );

        new PlainButton(this, "showActionSheet", 0xFF0000, 0xFFFF00, {x: 100, y: 460, width : 200, height : 60},
            function clickHandler(event:Event):void {
                showActionSheet("Info", "Hi");
            }
        );

        new PlainButton(this, "showTitleAlert", 0xFF0000, 0xFFFF00, {x: 100, y: 520, width : 200, height : 60},
            function clickHandler(event:Event):void {
                var alertController: Alert = new Alert("Processing...", null, AlertStyle.alert);
                alertController.present();
                setTimeout(function (): void {
                    alertController.dismiss();
                }, 2000);
            }
        );

        new PlainButton(this, "sendLocalNotification", 0xFF0000, 0xFFFF00, {x: 100, y: 580, width : 200, height : 60},
            function clickHandler(event:Event):void {
                var content: NotificationContent = new NotificationContent();
                content.title = "Title";
                content.body = "Message";
                content.userInfo = {message: "Hello, world!"};

                var trigger: TimeIntervalNotificationTrigger = new TimeIntervalNotificationTrigger(8);
                var request: NotificationRequest = new NotificationRequest(1, content, trigger);

                NotificationCenter.current.add(request, function (error: Error) {
                    trace(error);
                });
            }
        );

        new PlainButton(this, "localNotificationEnabled", 0xFF0000, 0xFFFF00, {x: 100, y: 640, width : 200, height : 60},
            function clickHandler(event:Event):void {
                log(NotificationCenter.isEnabled);
            }
        );
        new PlainButton(this, "localNotificationCanOpenSettings", 0xFF0000, 0xFFFF00, {x: 100, y: 700, width : 200, height : 60},
            function clickHandler(event:Event):void {
                log(NotificationCenter.canOpenSettings);
            }
        );
        new PlainButton(this, "localNotificationOpenSettings", 0xFF0000, 0xFFFF00, {x: 100, y: 760, width : 200, height : 60},
            function clickHandler(event:Event):void {
                NotificationCenter.openSettings();
            }
        );
        new PlainButton(this, "Request Authorization", 0xFF0000, 0xFFFF00, {x: 100, y: 820, width : 200, height : 60},
            function clickHandler(event:Event):void {
                var options: int = NotificationCenterAuthorizationOptions.alert.rawValue | NotificationCenterAuthorizationOptions.sound.rawValue;
                NotificationCenter.requestAuthorizationWithOptions(options, function (status: String, error: Error = null) {
                    log(status, error);
                });
            }
        );
        new PlainButton(this, "Get Notification Settings", 0xFF0000, 0xFFFF00, {x: 100, y: 900, width : 200, height : 60},
            function clickHandler(event:Event):void {
                NotificationCenter.getNotificationSettingsWithCompletion(function (settings: NotificationCenterSettings) {
                    log(settings.authorizationStatus);
                });
            }
        );

        new PlainButton(this, "isThemeSupported", 0xFF0000, 0xFFFF00, {x: 400, y: 80, width : 200, height : 60},
                function clickHandler(event:Event):void {
                    log(Theme.isSupported);
                }
        );
        new PlainButton(this, "setLightTheme", 0xFF0000, 0xFFFF00, {x: 400, y: 160, width : 200, height : 60},
            function clickHandler(event:Event):void {
                Theme.shared.style = ThemeStyle.Light;
            }
        );
        new PlainButton(this, "setDarkTheme", 0xFF0000, 0xFFFF00, {x: 400, y: 240, width : 200, height : 60},
            function clickHandler(event:Event):void {
                Theme.shared.style = ThemeStyle.Dark;
            }
        );
        new PlainButton(this, "setMaterialDarkTheme", 0xFF0000, 0xFFFF00, {x: 400, y: 320, width : 200, height : 60},
            function clickHandler(event:Event):void {
                Theme.shared.android.style = ThemeAndroidStyle.MaterialDark;
            }
        );
        new PlainButton(this, "setMaterialLightTheme", 0xFF0000, 0xFFFF00, {x: 400, y: 400, width : 200, height : 60},
            function clickHandler(event:Event):void {
                Theme.shared.android.style = ThemeAndroidStyle.MaterialLight;
            }
        );
        new PlainButton(this, "setHoloDarkTheme", 0xFF0000, 0xFFFF00, {x: 400, y: 480, width : 200, height : 60},
            function clickHandler(event:Event):void {
                Theme.shared.android.style = ThemeAndroidStyle.HoloDark;
            }
        );
        new PlainButton(this, "setHoloLightTheme", 0xFF0000, 0xFFFF00, {x: 400, y: 560, width : 200, height : 60},
            function clickHandler(event:Event):void {
                Theme.shared.android.style = ThemeAndroidStyle.HoloLight;
            }
        );
        new PlainButton(this, "setAirDefaultTheme", 0xFF0000, 0xFFFF00, {x: 400, y: 640, width : 200, height : 60},
            function clickHandler(event:Event):void {
                Theme.shared.android.style = ThemeAndroidStyle.NoShadow;
            }
        );

        NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, function(event: InvokeEvent): void {
            trace(event.arguments, event.reason);
            tf.text += event.arguments + " " + event.reason +"\n";
        });

        NotificationCenter.current.addEventListener(NotificationCenterEvent.NOTIFICATION_RECEIVED, function (event: NotificationCenterEvent): void {
            log(event.parameters);
        });

        function log(...rest): void {
            trace(rest);
            tf.text += rest + "\n";
            tf.scrollV = tf.maxScrollV;
        }

        var tf:TextField = new TextField();
        tf.border = true;
        tf.width = 600;
        tf.x = 20;
        tf.text = "Initializing...";
        tf.y = 980;
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

    private function showAlert(title: String, message: String): void {
        var alertController: Alert = new Alert(title, message, AlertStyle.alert);
        alertController.addAction(new AlertAction("OK", AlertActionStyle.normal, function(): void{
            trace("OK");
        }));
        alertController.present();
    }
    private function showActionSheet(title: String, message: String): void {
        var alertController: Alert = new Alert(title, message, AlertStyle.actionSheet);
        alertController.addAction(new AlertAction("Cancel", AlertActionStyle.cancellation, function(): void{
            trace("Cancel");
        }));
        alertController.addAction(new AlertAction("Delete", AlertActionStyle.destructive, function(): void{
            trace("Delete");
        }));
        alertController.addAction(new AlertAction("Send", AlertActionStyle.normal, function(): void{
            trace("send");
        }));
        alertController.present();
    }
}
}

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
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
