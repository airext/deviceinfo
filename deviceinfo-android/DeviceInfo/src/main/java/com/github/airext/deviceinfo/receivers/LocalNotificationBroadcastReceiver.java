package com.github.airext.deviceinfo.receivers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import com.github.airext.deviceinfo.managers.NotificationCenter;

/**
 * Created by max on 12/3/17.
 */

public class LocalNotificationBroadcastReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {

        NotificationCenter.handleAlarmReceived(context, intent);
    }
}
