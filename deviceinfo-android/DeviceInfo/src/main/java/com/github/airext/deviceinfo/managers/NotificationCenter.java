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
import android.provider.Settings;
import android.util.Log;
import com.distriqt.extension.Resources;
import com.github.airext.DeviceInfo;
import com.github.airext.deviceinfo.data.NotificationCenterSettings;
import com.github.airext.deviceinfo.permissions.PermissionManager;
import com.github.airext.deviceinfo.receivers.LocalNotificationBroadcastReceiver;
import com.github.airext.deviceinfo.utils.AssetsUtil;
import com.github.airext.deviceinfo.utils.ContentProviderUtil;
import com.github.airext.deviceinfo.utils.DispatchQueue;

import java.io.File;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;
import java.util.Stack;

import static android.content.Context.ALARM_SERVICE;

/**
 * Created by max on 12/4/17.
 */

public class NotificationCenter {

    private static final String TAG = "NotificationCenter";

    // Keys

    private static final String identifierKey = "com.github.airext.deviceinfo.managers.NotificationCenter.identifier";
    private static final String titleKey      = "com.github.airext.deviceinfo.managers.NotificationCenter.title";
    private static final String bodyKey       = "com.github.airext.deviceinfo.managers.NotificationCenter.body";
    private static final String soundKey      = "com.github.airext.deviceinfo.managers.NotificationCenter.sound";
    private static final String userInfoKey   = "com.github.airext.deviceinfo.managers.NotificationCenter.params";

    private static final int REQUEST_PERMISSIONS_CODE = 42;

    // Availability & Permissions

    public static Boolean isSupported() {
        return true;
    }

    public static String permissionStatus(Context context) {
        Log.d(TAG, "permissionStatus");

        Boolean isSetAlarmGranted = PermissionManager.checkIfPermissionsGranted(context, Manifest.permission.SET_ALARM);
        Boolean isReadExternalStorageGranted = PermissionManager.checkIfPermissionsGranted(context, Manifest.permission.READ_EXTERNAL_STORAGE);

        if (isSetAlarmGranted && isReadExternalStorageGranted) {
            return "granted";
        } else {
            return "denied";
        }
    }

    public static void requestAuthorizationWithOptions(final Activity activity, int options, final AuthorizationStatusListener listener) {
        Log.d(TAG, "requestAuthorizationWithOptions");

        PermissionManager.requestPermissions(activity, new String[]{Manifest.permission.SET_ALARM, Manifest.permission.READ_EXTERNAL_STORAGE}, new PermissionManager.Listener() {
            @Override
            public void onPermissionsCheck(String[] grantedPermissions, String[] deniedPermissions) {
                if (listener != null) {
                    List<String> granted = Arrays.asList(grantedPermissions);
                    if (granted.contains(Manifest.permission.SET_ALARM) &&
                        granted.contains(Manifest.permission.READ_EXTERNAL_STORAGE)) {
                        listener.onStatus("granted");
                        return;
                    }
                    List<String> denied = Arrays.asList(deniedPermissions);
                    if (denied.contains(Manifest.permission.SET_ALARM) &&
                        denied.contains(Manifest.permission.READ_EXTERNAL_STORAGE)) {
                        listener.onStatus("denied");
                        return;
                    }
                    listener.onStatus("unknown");
                }
            }
        });
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

        notifyAppWithDataIfAvailable(context, intent, false);
    }
    public static void inBackground() {
        Log.d(TAG, "inBackground");

        _isInForeground = false;
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

    public static void scheduleNotification(Context context, int identifier, long timestamp, String title, String body, String sound, String userInfo) {
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
        intent.putExtra(soundKey, sound);
        intent.putExtra(userInfoKey, userInfo);

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

        int identifier = intent.getIntExtra(identifierKey, 0);
        String title   = intent.getStringExtra(titleKey);
        String content = intent.getStringExtra(bodyKey);
        String sound   = intent.getStringExtra(soundKey);
        String userInfo = intent.getStringExtra(userInfoKey);

        Intent notificationIntent = null;
        try {
            notificationIntent = new Intent(context, Class.forName(context.getPackageName() + ".AppEntry"));
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        notificationIntent.putExtra(userInfoKey, userInfo);
        notificationIntent.putExtra(identifierKey, identifier);

        PendingIntent pendingIntent = PendingIntent.getActivity(context, 0, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT);

        int smallIconId = Resources.getResourseIdByName(context.getPackageName(), "mipmap", "icon");
        int largeIconId = Resources.getResourseIdByName(context.getPackageName(), "mipmap", "icon");

        Uri soundUri = null;
        if (sound != null) {
            File audioFile = AssetsUtil.copyAssetToTempFileIfNeeded(context, sound);
            if (audioFile != null) {
                soundUri = ContentProviderUtil.getAudioContentUri(context, audioFile);
            }
        }

        if (soundUri == null) {
            soundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
        }

        Notification notification = new Notification.Builder(context)
            .setSmallIcon(smallIconId)
            .setLargeIcon(BitmapFactory.decodeResource(context.getResources(), largeIconId))
            .setContentTitle(title)
            .setContentText(content)
            .setAutoCancel(true)
            .setWhen(System.currentTimeMillis())
            .setSound(soundUri)
            .setContentIntent(pendingIntent)
            .build();

        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.notify(identifier, notification);
    }

    private static void notifyAppWithDataIfAvailable(Context context, Intent intent, Boolean notifyForForeground) {
        Log.d(TAG, "notifyAppWithDataIfAvailable");

        if (intent.hasExtra(identifierKey) && intent.hasExtra(userInfoKey)) {
            int identifier = intent.getIntExtra(identifierKey, 0);
            intent.removeExtra(identifierKey);
            String params  = intent.getStringExtra(userInfoKey);
            intent.removeExtra(userInfoKey);

            if (notifyForForeground) {
                DeviceInfo.dispatch("DeviceInfo.NotificationCenter.Notification.ReceivedInForeground", params);
            } else {
                DeviceInfo.dispatch("DeviceInfo.NotificationCenter.Notification.ReceivedInBackground", params);
            }
        }
    }

    public static void handleAlarmReceived(Context context, Intent intent) {
        Log.d(TAG, "handleAlarmReceived");

        if (isInForeground()) {
            notifyAppWithDataIfAvailable(context, intent, true);
        } else {
            showNotification(context, intent);
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
