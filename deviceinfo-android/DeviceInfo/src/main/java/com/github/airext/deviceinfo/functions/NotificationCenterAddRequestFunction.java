package com.github.airext.deviceinfo.functions;

import android.app.*;
import android.content.Context;
import android.content.Intent;
import com.adobe.fre.*;
import com.github.airext.bridge.Bridge;
import com.github.airext.bridge.Call;
import com.github.airext.deviceinfo.managers.NotificationCenter;
import com.github.airext.deviceinfo.receivers.LocalNotificationBroadcastReceiver;
import com.github.airext.deviceinfo.utils.ConversionRoutines;

import java.util.Calendar;

/**
 * Created by max on 12/3/17.
 */

public class NotificationCenterAddRequestFunction implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        Activity activity = context.getActivity();

        int identifier   = 0;
        String title     = null;
        String body      = null;
        String userInfo  = null;
        int timeInterval = 0;

        try {
            FREObject request = args[0];
            FREObject content = request.getProperty("content");
            FREObject trigger = request.getProperty("trigger");

            identifier = ConversionRoutines.readIntPropertyFrom(request, "identifier", 0);

            title = ConversionRoutines.readStringPropertyFrom(content, "title");
            body  = ConversionRoutines.readStringPropertyFrom(content, "body");

            FREObject userInfoAsFREObject = content.callMethod("userInfoAsJSON", null);
            if (userInfoAsFREObject != null) {
                userInfo = userInfoAsFREObject.getAsString();
            }

            if (trigger != null) {
                timeInterval = ConversionRoutines.readIntPropertyFrom(trigger, "timeInterval", 0);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        final Call call = Bridge.call(context);

        if (timeInterval > 0) {
            Calendar calendar = Calendar.getInstance();
            long timestamp = calendar.getTimeInMillis() + timeInterval * 1000;

            NotificationCenter.scheduleNotification(activity, identifier, timestamp, title, body, userInfo);

            dispatch_async(activity, new Runnable() {
                @Override
                public void run() {
                    call.result(true);
                }
            });
        } else {
            dispatch_async(activity, new Runnable() {
                @Override
                public void run() {
                    call.reject("Specified timeInterval is invalid");
                }
            });
        }

        return call.toFREObject();
    }

    private void dispatch_async(final Activity activity, final Runnable runnable) {
        new Thread() {
            @Override
            public void run() {
                activity.runOnUiThread(runnable);
            }
        };
    }
}
