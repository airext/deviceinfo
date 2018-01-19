package com.github.airext.deviceinfo.managers;

import android.Manifest;
import android.app.*;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.graphics.BitmapFactory;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;
import android.os.Process;
import android.provider.Settings;
import android.util.Log;
import com.distriqt.extension.Resources;
import com.github.airext.DeviceInfo;
import com.github.airext.deviceinfo.data.NotificationCenterSettings;
import com.github.airext.deviceinfo.receivers.LocalNotificationBroadcastReceiver;
import com.github.airext.deviceinfo.utils.DispatchQueue;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Stack;

import static android.content.Context.ALARM_SERVICE;

/**
 * Created by max on 12/4/17.
 */

public class NotificationCenter {

    private static final String TAG = "NotificationCenter";

    // Keys

    private static final String identifierKey = "com.github.airext.deviceinfo.managers.NotificationCenter.title";
    private static final String titleKey      = "com.github.airext.deviceinfo.managers.NotificationCenter.title";
    private static final String bodyKey       = "com.github.airext.deviceinfo.managers.NotificationCenter.body";
    private static final String paramsKey     = "com.github.airext.deviceinfo.managers.NotificationCenter.params";

    // Availability & Permissions

    public static Boolean isSupported() {
        return true;
    }

    public static String permissionStatus(Context context) {
        Log.d(TAG, "permissionStatus");

        int status  = context.checkPermission(Manifest.permission.SET_ALARM, android.os.Process.myPid(), Process.myUid());

        if (status == PackageManager.PERMISSION_GRANTED) {
            return "granted";
        } else if (status == PackageManager.PERMISSION_DENIED) {
            return "denied";
        } else {
            return "unknown";
        }
    }

    public static void requestAuthorizationWithOptions(Activity activity, int options, final AuthorizationStatusListener listener) {
        Log.d(TAG, "requestAuthorizationWithOptions");

        final String status = permissionStatus(activity);

        if (listener != null) {
            DispatchQueue.dispatch_async(activity, new Runnable() {
                @Override
                public void run() {
                    listener.onStatus(status);
                }
            });
        }
    }

    public static Boolean isEnabled(Context context) {
        Log.d(TAG, "isEnabled");

        if (Build.VERSION.SDK_INT >= 24) {
            NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
            if (notificationManager != null) {
                return notificationManager.areNotificationsEnabled();
            } else {
                return false;
            }
        } else if (Build.VERSION.SDK_INT >= 19) {
            AppOpsManager appOps = (AppOpsManager) context.getSystemService(Context.APP_OPS_SERVICE);
            ApplicationInfo appInfo = context.getApplicationInfo();
            String pkg = context.getApplicationContext().getPackageName();
            int uid = appInfo.uid;
            try {
                Class<?> appOpsClass = Class.forName(AppOpsManager.class.getName());
                Method checkOpNoThrowMethod = appOpsClass.getMethod("checkOpNoThrow", Integer.TYPE, Integer.TYPE, String.class);
                Field opPostNotificationValue = appOpsClass.getDeclaredField("OP_POST_NOTIFICATION");
                int value = (Integer) opPostNotificationValue.get(Integer.class);
                return ((Integer) checkOpNoThrowMethod.invoke(appOps, value, uid, pkg) == AppOpsManager.MODE_ALLOWED);
            } catch (ClassNotFoundException | NoSuchMethodException | NoSuchFieldException | InvocationTargetException | IllegalAccessException | RuntimeException e) {
                return true;
            }
        } else {
            return true;
        }
    }

    public static Boolean canOpenSettings(Context context) {
        Log.d(TAG, "canOpenSettings");

        Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
        Uri uri = Uri.fromParts("package", context.getPackageName(), null);
        intent.setData(uri);
        return intent.resolveActivity(context.getPackageManager()) != null;
    }

    public static void openSettings(Context context) {
        Log.d(TAG, "openSettings");

        Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
        Uri uri = Uri.fromParts("package", context.getPackageName(), null);
        intent.setData(uri);
        context.startActivity(intent);
    }

    // Background / Foreground

    private static Boolean _isInForeground = false;
    public static Boolean isInForeground() {
        return _isInForeground;
    }

    public static void inForeground(Context context, Intent intent) {
        Log.d(TAG, "inForeground");

        _isInForeground = true;

        notifyAppWithDataIfAvailable(context, intent);
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

    // API: Settings

    public static void getNotificationSettings(Activity activity, final NotificationSettingsListener listener) {
        Log.d(TAG, "getNotificationSettings");

        final String authorizationStatus = permissionStatus(activity);
        if (listener != null) {
            DispatchQueue.dispatch_async(activity, new Runnable() {
                @Override
                public void run() {
                    listener.onSettings(new NotificationCenterSettings(authorizationStatus));
                }
            });
        }
    }

    // API: Notifications

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

        Intent notificationIntent = null;
        try {
            notificationIntent = new Intent(context, Class.forName(context.getPackageName() + ".AppEntry"));
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
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

    private static void notifyAppWithDataIfAvailable(Context context, Intent intent) {
        Log.d(TAG, "notifyAppWithDataIfAvailable");

        if (intent.hasExtra(identifierKey) && intent.hasExtra(paramsKey)) {
            int identifier = intent.getIntExtra(identifierKey, 0);
            intent.removeExtra(identifierKey);
            String params  = intent.getStringExtra(paramsKey);
            intent.removeExtra(paramsKey);

            DeviceInfo.dispatch("DeviceInfo.NotificationCenter.Data.Receive", params);
        }
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
            notifyAppWithDataIfAvailable(context, intent);
        } else {
            showNotification(context, intent);
        }
    }

    public static void handleNotificationReceived(Context context, Intent intent) {
        Log.d(TAG, "handleNotificationReceived");

        if (isInForeground()) {
            notifyAppWithDataIfAvailable(context, intent);
        } else {
            keepDataForLaunch(context, intent);
        }
    }

    // Callbacks

    public interface AuthorizationStatusListener {
        void onStatus(String status);
    }

    public interface NotificationSettingsListener {
        void onSettings(NotificationCenterSettings settings);
    }
}
