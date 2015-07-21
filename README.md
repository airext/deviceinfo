deviceinfo ![License MIT](http://img.shields.io/badge/license-MIT-lightgray.svg)
==========

![iOS](http://img.shields.io/badge/platform-ios-blue.svg) ![Android](http://img.shields.io/badge/platform-android-green.svg)

This [AIR Native Extension](http://www.adobe.com/devnet/air/native-extensions-for-air.html) provides device basic information.

### imei

```as3
DeviceInfo.sharedInstance().imei;
```
Returns IMEI as string, **not supported** on iOS.

### General Info
```as3
DeviceInfo.sharedInstance().general;
```
Provides access for `DeviceInfoGeneral` object that describes device's general information:
```as3
DeviceGeneralInfo
{
  public var name:String;
  public var model:String;
  public var vendor:String;
  public var systemName:String;
  public var systemVersion:String;
  public var platform:String;
}
```

#### iOS General Info
```as3
DeviceInfo.sharedInstance().general.ios;
```
Provide access to `DeviceInfoGeneralIOS` object that describes iOS specific info:
```as3
DeviceInfoGeneralIOS
{
  /** Returns iOS identifier for vendor */
  public function getVendorIdentifier():String;
}
```

#### Android General Info
```as3
DeviceInfo.sharedInstance().general.android
```
Provide access to `DeviceInfoGeneralAndroid` object that describes Android specific info:
```as3
DeviceInfoGeneralAndroid
{
  /** Returns Android Identifier */
  public function getAndroidIdentifier():String;
}
```

### Battery Info
```as3
DeviceInfo.sharedInstance().battery;
```
Provides access to `DeviceInfoBattery` object that describes Battery state:
```as3
DeviceInfoBattery
{
  public var level:Number;
  public var state:String;
  public function get isMonitoring():Boolean;
  public function startMonitoring():void;
  public function stopMonitoring():void;
}

