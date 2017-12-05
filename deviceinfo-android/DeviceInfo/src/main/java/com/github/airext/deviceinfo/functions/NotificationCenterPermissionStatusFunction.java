package com.github.airext.deviceinfo.functions;

import android.app.Activity;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.github.airext.deviceinfo.managers.NotificationCenter;

/**
 * Created by max on 12/3/17.
 */

public class NotificationCenterPermissionStatusFunction implements FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        Activity activity = context.getActivity();

        try {
            return FREObject.newObject(NotificationCenter.permissionStatus(activity));
        } catch (FREWrongThreadException e) {
            e.printStackTrace();
        }

        return null;
    }
}
