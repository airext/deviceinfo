package com.github.airext.deviceinfo.functions;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Handler;
import android.os.Looper;
import android.support.v4.app.ActivityCompat;
import android.util.Log;
import com.adobe.fre.*;
import com.github.airext.DeviceInfo;
import com.github.airext.bridge.Bridge;
import com.github.airext.bridge.Call;
import com.github.airext.deviceinfo.managers.NotificationCenter;
import com.github.airext.deviceinfo.utils.DispatchQueue;

/**
 * Created by max on 12/3/17.
 */

public class NotificationCenterRequestAuthorizationFunction implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        Log.d(DeviceInfo.TAG, "NotificationCenterRequestAuthorizationFunction");

        final Activity activity = context.getActivity();

        final Call call = Bridge.call(context);

        int options = 0;

        if (args.length > 0) {
            try {
                options = args[0].getAsInt();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        NotificationCenter.requestAuthorizationWithOptions(activity, options, new NotificationCenter.AuthorizationStatusListener() {
            @Override
            public void onStatus(String status) {
                call.result(status);
            }
        });

        return call.toFREObject();
    }
}
