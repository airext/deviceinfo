package com.github.airext.deviceinfo.functions;

import android.Manifest;
import android.app.Activity;
import android.support.v4.app.ActivityCompat;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

/**
 * Created by max on 12/3/17.
 */

public class NotificationCenterRequestPermissionFunction implements FREFunction {

    private static int setAlarmPermissionRequestCode = 101010;

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        Activity activity = context.getActivity();

        ActivityCompat.requestPermissions(activity, new String[]{Manifest.permission.SET_ALARM}, setAlarmPermissionRequestCode);



        return null;
    }
}
