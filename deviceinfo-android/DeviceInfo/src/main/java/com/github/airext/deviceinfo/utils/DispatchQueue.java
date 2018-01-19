package com.github.airext.deviceinfo.utils;

import android.app.Activity;

/**
 * Created by max on 12/10/17.
 */

public class DispatchQueue {
    public static void dispatch_async(final Activity activity, final Runnable runnable) {
        new Thread() {
            @Override
            public void run() {
                activity.runOnUiThread(runnable);
            }
        }.start();
    }
}
