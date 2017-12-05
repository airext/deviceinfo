package com.github.airext.deviceinfo.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.github.airext.deviceinfo.managers.NotificationCenter;

/**
 * Created by max on 12/5/17.
 */

public class NotificationCenterInBackgroundFunction implements com.adobe.fre.FREFunction {
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        NotificationCenter.inBackground();
        return null;
    }
}
