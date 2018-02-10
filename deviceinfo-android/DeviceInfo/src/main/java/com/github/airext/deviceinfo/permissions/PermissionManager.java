package com.github.airext.deviceinfo.permissions;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Process;
import android.util.Log;

/**
 * Created by max on 2/10/18.
 */

public class PermissionManager {

    // Constants

    public static final String TAG = "PermissionManager";

    public static final String permissionsKey = "com.github.airext.deviceinfo.permissions.PermissionManager.permissions";

    // Check permission

    public static Boolean checkIfPermissionsGranted(Context context, String permission) {
        Log.d(TAG, "checkIfPermissionsGranted");
        int status = context.checkPermission(permission, android.os.Process.myPid(), Process.myUid());
        Log.d(TAG, "Permission " + permission + " status: " + status);
        return status == PackageManager.PERMISSION_GRANTED;
    }

    private static Boolean checkIfPermissionsGranted(Context context, String[] permissions) {
        Log.d(TAG, "checkIfPermissionsGranted");
        for (String permission: permissions) {
            if (!checkIfPermissionsGranted(context, permission)) {
                return false;
            }
        }
        return true;
    }

    // Request permissions

    private static Listener _listener;

    public static void requestPermissions(Context context, String[] permissions, Listener listener) {
        Log.d(TAG, "requestPermissions");

        if (checkIfPermissionsGranted(context, permissions)) {
            Log.d(TAG, "All permissions granted");
            if (listener != null) {
                listener.onPermissionsCheck(permissions, new String[]{});
            }
            return;
        }

        _listener = listener;

        startTransparentActivityIfNeeded(context, permissions);
    }

    // Start helper Activity

    private static void startTransparentActivityIfNeeded(Context context, String[] permissions) {
        Log.d(TAG, "startTransparentActivityIfNeeded");

        if (context == null) {
            return;
        }

        Intent intent = new Intent(context, PermissionsRequestActivity.class);
        intent.putExtra(permissionsKey, permissions);

        if (context instanceof Application) {
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        }

        context.startActivity(intent);

        if (context instanceof Activity) {
            ((Activity) context).overridePendingTransition(0, 0);
        }
    }

    // Activity handlers

    static void onActivityReady(PermissionsRequestActivity activity) {
        Log.d(TAG, "onActivityReady");
    }

    static void onActivityDestroyed() {
        Log.d(TAG, "onActivityDestroyed");

        if (_listener != null) {
            _listener.onPermissionsCheck(new String[0], new String[0]);
            _listener = null;
        }
    }

    static void onPermissionsRequested(String[] grantedPermissions, String[] deniedPermissions) {
        Log.d(TAG, "onPermissionsRequested");

        if (_listener != null) {
            _listener.onPermissionsCheck(grantedPermissions, deniedPermissions);
            _listener = null;
        }
    }

    // Listener

    public interface Listener {
        void onPermissionsCheck(String[] grantedPermissions, String[] deniedPermissions);
    }
}
