package com.github.airext.deviceinfo.functions;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Handler;
import android.os.Looper;
import android.support.v4.app.ActivityCompat;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.github.airext.bridge.Bridge;
import com.github.airext.bridge.Call;
import com.github.airext.deviceinfo.utils.DispatchQueue;

/**
 * Created by max on 12/3/17.
 */

public class NotificationCenterRequestAuthorizationFunction implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        Activity activity = context.getActivity();

        final Call call = Bridge.call(context);

        DispatchQueue.dispatch_async(activity, new Runnable() {
            @Override
            public void run() {
                call.result("granted");
            }
        });

        return call.toFREObject();
    }
}
