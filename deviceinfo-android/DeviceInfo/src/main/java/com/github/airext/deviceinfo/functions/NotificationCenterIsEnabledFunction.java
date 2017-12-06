package com.github.airext.deviceinfo.functions;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.github.airext.deviceinfo.managers.NotificationCenter;

/**
 * Created by max on 12/6/17.
 */

public class NotificationCenterIsEnabledFunction implements com.adobe.fre.FREFunction {
    private static final String TAG = "NotificationCenter";

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        Log.d(TAG, "NotificationCenterIsEnabledFunction");

        try {
            return FREObject.newObject(NotificationCenter.isEnabled(context.getActivity()));
        } catch (FREWrongThreadException e) {
            e.printStackTrace();
        }
        return null;
    }
}
