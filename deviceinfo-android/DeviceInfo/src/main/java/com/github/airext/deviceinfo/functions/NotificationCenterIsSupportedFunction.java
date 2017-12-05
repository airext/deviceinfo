package com.github.airext.deviceinfo.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.github.airext.deviceinfo.managers.NotificationCenter;

/**
 * Created by max on 12/3/17.
 */

public class NotificationCenterIsSupportedFunction implements FREFunction {
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        try {
            return FREObject.newObject(NotificationCenter.isSupported());
        } catch (FREWrongThreadException e) {
            e.printStackTrace();
        }
        return null;
    }
}
