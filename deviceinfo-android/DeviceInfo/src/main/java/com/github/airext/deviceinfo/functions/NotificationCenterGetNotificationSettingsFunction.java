package com.github.airext.deviceinfo.functions;

import android.app.Activity;
import android.util.Log;
import com.adobe.fre.*;
import com.github.airext.DeviceInfo;
import com.github.airext.bridge.Bridge;
import com.github.airext.bridge.Call;
import com.github.airext.bridge.CallResultValue;
import com.github.airext.deviceinfo.data.NotificationCenterSettings;
import com.github.airext.deviceinfo.managers.NotificationCenter;
import com.github.airext.deviceinfo.utils.DispatchQueue;

/**
 * Created by max on 12/3/17.
 */

public class NotificationCenterGetNotificationSettingsFunction implements FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        Log.d(DeviceInfo.TAG, "NotificationCenterGetNotificationSettingsFunction");

        Activity activity = context.getActivity();

        final Call call = Bridge.call(context);

        NotificationCenter.getNotificationSettings(activity, new NotificationCenter.NotificationSettingsListener() {
            @Override
            public void onSettings(NotificationCenterSettings settings) {
                call.result(settings);
            }
        });

        return call.toFREObject();
    }
}