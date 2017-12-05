package com.github.airext.deviceinfo.utils;

import com.adobe.fre.*;

/**
 * Created by max on 12/5/17.
 */

public class ConversionRoutines {
    public static String toString(FREObject object) {
        try {
            if (object != null) {
                return object.getAsString();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String readStringPropertyFrom(FREObject object, String property) {
        try {
            FREObject value = object.getProperty(property);
            if (value != null) {
                return value.getAsString();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static int readIntPropertyFrom(FREObject object, String property, int defaultValue) {
        try {
            FREObject value = object.getProperty(property);
            if (value != null) {
                return value.getAsInt();
            } else {
                return defaultValue;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return defaultValue;
    }
}
