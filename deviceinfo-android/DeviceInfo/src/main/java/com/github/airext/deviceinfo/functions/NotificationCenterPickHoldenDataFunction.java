package com.github.airext.deviceinfo.functions;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.github.airext.DeviceInfo;

/**
 * Created by max on 12/5/17.
 */

public class NotificationCenterPickHoldenDataFunction implements FREFunction {

    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Log.d(DeviceInfo.TAG, "NotificationCenterPickHoldenDataFunction");
        return null;
    }
}
