package com.github.airext.deviceinfo.managers;

import android.Manifest;
import android.app.*;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.BitmapFactory;
import android.media.RingtoneManager;
import android.net.Uri;
import android.support.v4.content.ContextCompat;
import android.util.Log;
import com.distriqt.extension.Resources;
import com.github.airext.DeviceInfo;
import com.github.airext.deviceinfo.activities.NotificationActivity;
import com.github.airext.deviceinfo.receivers.LocalNotificationBroadcastReceiver;

import java.util.Stack;

import static android.content.Context.ALARM_SERVICE;

/**
 * Created by max on 12/4/17.
 */

public class NotificationCenter {

    private static String TAG = "NotificationCenter";

    // Keys

    private static final String identifierKey = "title";
    private static final String titleKey      = "title";
    private static final String bodyKey       = "body";
    private static final String paramsKey     = "params";

    // Availability & Permissions

    public static Boolean isSupported() {
        return true;
    }

    public static String permissionStatus(Context context) {
        int status = ContextCompat.checkSelfPermission(context, Manifest.permission.SET_ALARM);

        if (status == PackageManager.PERMISSION_GRANTED) {
            return "granted";
        } else if (status == PackageManager.PERMISSION_DENIED) {
            return "denied";
        } else {
            return "unknown";
        }
    }

    // Background / Foreground

    private static Boolean _isInForeground = false;
    public static Boolean isInForeground() {
        return _isInForeground;
    }

    public static void inForeground() {
        Log.d(TAG, "inForeground");

        _isInForeground = true;
        sendDataFromStackIfAvailable();
    }
    public static void inBackground() {
        Log.d(TAG, "inBackground");

        _isInForeground = false;
    }

    // Working with Data Stack

    private static Stack<String> receivedData = new Stack<String>();
    private static void pushDataToStack(String data) {
        receivedData.push(data);
    }
    private static void sendDataFromStackIfAvailable() {
        while (!receivedData.empty()) {
            DeviceInfo.dispatch("DeviceInfo.NotificationCenter.Data.Receive", receivedData.pop());
        }
    }

    // API

    public static void scheduleNotification(Context context, int identifier, long timestamp, String title, String body, String userInfo) {
        Log.d(TAG, "scheduleNotification");

        // cancel already scheduled reminders
        removePendingNotificationWithId(context, identifier);

        // Enable a receiver

        ComponentName receiver = new ComponentName(context, LocalNotificationBroadcastReceiver.class);
        PackageManager pm = context.getPackageManager();

        pm.setComponentEnabledSetting(receiver, PackageManager.COMPONENT_ENABLED_STATE_ENABLED, PackageManager.DONT_KILL_APP);

        Intent intent = new Intent(context, LocalNotificationBroadcastReceiver.class);
        intent.putExtra(identifierKey, identifier);
        intent.putExtra(titleKey, title);
        intent.putExtra(bodyKey, body);
        intent.putExtra(paramsKey, userInfo);

        PendingIntent pendingIntent = PendingIntent.getBroadcast(context, identifier, intent, PendingIntent.FLAG_UPDATE_CURRENT);

        AlarmManager alarmManager = (AlarmManager) context.getSystemService(ALARM_SERVICE);
        alarmManager.set(AlarmManager.RTC_WAKEUP, timestamp, pendingIntent);
    }

    public static void removePendingNotificationWithId(Context context, int identifier) {
        Log.d(TAG, "removePendingNotificationWithId");

        ComponentName receiver = new ComponentName(context, LocalNotificationBroadcastReceiver.class);
        PackageManager pm = context.getPackageManager();

        pm.setComponentEnabledSetting(receiver, PackageManager.COMPONENT_ENABLED_STATE_DISABLED, PackageManager.DONT_KILL_APP);

        Intent intent = new Intent(context, LocalNotificationBroadcastReceiver.class);
        PendingIntent pendingIntent = PendingIntent.getBroadcast(context, identifier, intent, PendingIntent.FLAG_UPDATE_CURRENT);
        AlarmManager am = (AlarmManager) context.getSystemService(ALARM_SERVICE);
        am.cancel(pendingIntent);
        pendingIntent.cancel();
    }

    public static void removeAllPendingNotificationRequests(Context context) {
        // TODO: seems to be unsupported on Android
    }

    public static void showNotification(Context context, Intent intent) {
        Log.d(TAG, "showNotification");

        Uri alarmSound = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
        int identifier = intent.getIntExtra(identifierKey, 0);
        String title   = intent.getStringExtra(titleKey);
        String content = intent.getStringExtra(bodyKey);
        String params  = intent.getStringExtra(paramsKey);

        Intent notificationIntent = new Intent(context, NotificationActivity.class);
        notificationIntent.putExtra(paramsKey, params);
        notificationIntent.putExtra(identifierKey, identifier);

        PendingIntent pendingIntent = PendingIntent.getActivity(context, 0, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT);

        int smallIconId = Resources.getResourseIdByName(context.getPackageName(), "mipmap", "icon");
        int largeIconId = Resources.getResourseIdByName(context.getPackageName(), "mipmap", "icon");

        Notification notification = new Notification.Builder(context)
                .setSmallIcon(smallIconId)
                .setLargeIcon(BitmapFactory.decodeResource(context.getResources(), largeIconId))
                .setContentTitle(title)
                .setContentText(content)
                .setAutoCancel(true)
                .setWhen(System.currentTimeMillis())
                .setSound(alarmSound)
                .setContentIntent(pendingIntent)
                .build();

        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.notify(identifier, notification);
    }

    private static void notifyAppWithData(Context context, Intent intent) {
        Log.d(TAG, "notifyAppWithData");

        int identifier = intent.getIntExtra(identifierKey, 0);
        String params  = intent.getStringExtra(paramsKey);

        DeviceInfo.dispatch("DeviceInfo.NotificationCenter.Data.Receive", params);
    }

    private static void keepDataForLaunch(Context context, Intent intent) {
        Log.d(TAG, "keepDataForLaunch");

        int identifier = intent.getIntExtra(identifierKey, 0);
        String params  = intent.getStringExtra(paramsKey);

        pushDataToStack(params);
    }

    public static void handleAlarmReceived(Context context, Intent intent) {
        Log.d(TAG, "handleAlarmReceived");

        if (isInForeground()) {
            notifyAppWithData(context, intent);
        } else {
            showNotification(context, intent);
        }
    }

    public static void handleNotificationReceived(Context context, Intent intent) {
        Log.d(TAG, "handleNotificationReceived");

        if (isInForeground()) {
            notifyAppWithData(context, intent);
        } else {
            keepDataForLaunch(context, intent);
        }
    }
}
