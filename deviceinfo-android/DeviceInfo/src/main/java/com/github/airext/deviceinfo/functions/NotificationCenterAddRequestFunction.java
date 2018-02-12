package com.github.airext.deviceinfo.functions;

import android.app.*;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import com.adobe.fre.*;
import com.github.airext.DeviceInfo;
import com.github.airext.bridge.Bridge;
import com.github.airext.bridge.Call;
import com.github.airext.deviceinfo.managers.NotificationCenter;
import com.github.airext.deviceinfo.receivers.LocalNotificationBroadcastReceiver;
import com.github.airext.deviceinfo.utils.ConversionRoutines;
import com.github.airext.deviceinfo.utils.DispatchQueue;

import java.util.Calendar;

/**
 * Created by max on 12/3/17.
 */

public class NotificationCenterAddRequestFunction implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        Log.d(DeviceInfo.TAG, "NotificationCenterAddRequestFunction");

        Activity activity = context.getActivity();

        int identifier   = 0;
        String title     = null;
        String body      = null;
        String soundName = null;
        String userInfo  = null;
        int timeInterval = 0;

        try {
            FREObject request = args[0];
            FREObject content = request.getProperty("content");
            FREObject trigger = request.getProperty("trigger");
            FREObject sound   = content.getProperty("sound");

            identifier = ConversionRoutines.readIntPropertyFrom(request, "identifier", 0);

            title = ConversionRoutines.readStringPropertyFrom(content, "title");
            body  = ConversionRoutines.readStringPropertyFrom(content, "body");
            soundName = ConversionRoutines.readStringPropertyFrom(sound, "named");

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

        if (timeInterval < 0) {
            timeInterval = 0;
        }

        Calendar calendar = Calendar.getInstance();
        long timestamp = calendar.getTimeInMillis() + timeInterval * 1000;

        NotificationCenter.scheduleNotification(activity, identifier, timestamp, title, body, soundName, userInfo);

        DispatchQueue.dispatch_async(activity, new Runnable() {
            @Override
            public void run() {
                call.result(true);
            }
        });

        return call.toFREObject();
    }
}
