package com.github.airext.deviceinfo.functions;

import android.app.Activity;
import android.util.Log;
import com.adobe.fre.FREArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.github.airext.DeviceInfo;
import com.github.airext.deviceinfo.managers.NotificationCenter;

/**
 * Created by max on 12/3/17.
 */

public class NotificationCenterRemovePendingNotificationRequestsFunction implements FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        Log.d(DeviceInfo.TAG, "NotificationCenterRemovePendingNotificationRequestsFunction");

        Activity activity = context.getActivity();

        try {
            FREArray identifiers = (FREArray) args[0];
            for (long i = 0; i < identifiers.getLength(); i++) {
                NotificationCenter.removePendingNotificationWithId(activity, identifiers.getObjectAt(i).getAsInt());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
