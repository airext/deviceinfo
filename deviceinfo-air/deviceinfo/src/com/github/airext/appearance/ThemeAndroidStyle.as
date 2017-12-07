/**
 * Created by max.rozdobudko@gmail.com on 12/7/17.
 */
package com.github.airext.appearance {
public class ThemeAndroidStyle {

    public static const NoShadow: ThemeAndroidStyle             = new ThemeAndroidStyle(-1); // AIR default
    public static const MaterialDark: ThemeAndroidStyle         = new ThemeAndroidStyle(0x01030224);
    public static const MaterialLight: ThemeAndroidStyle        = new ThemeAndroidStyle(0x01030237);
    public static const HoloDark: ThemeAndroidStyle             = new ThemeAndroidStyle(0x0103006b);
    public static const HoloLight: ThemeAndroidStyle            = new ThemeAndroidStyle(0x01030237);
    public static const DeviceDefaultDark: ThemeAndroidStyle    = new ThemeAndroidStyle(0x01030128);
    public static const DeviceDefaultLight: ThemeAndroidStyle   = new ThemeAndroidStyle(0x0103012b);

    public static function from(style: ThemeStyle): ThemeAndroidStyle {
        switch (style) {
            case ThemeStyle.Dark :  return DeviceDefaultDark;
            case ThemeStyle.Light : return DeviceDefaultLight;
            default : return null;
        }
    }

    public function ThemeAndroidStyle(rawValue: int) {
        super();
        _rawValue = rawValue;
    }

    private var _rawValue: int;
    public function get rawValue(): int {
        return _rawValue;
    }
}
}
