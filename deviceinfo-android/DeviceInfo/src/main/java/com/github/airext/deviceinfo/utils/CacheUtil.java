package com.github.airext.deviceinfo.utils;

import android.content.Context;
import android.util.Log;
import com.github.airext.DeviceInfo;

import java.io.File;

/**
 * Created by max on 2/10/18.
 */
public class CacheUtil {

    public static File getFile(Context context, String name) {
        File dir = context.getExternalCacheDir();

        if (dir == null) {
            dir = context.getCacheDir();
        }

        if (dir == null) {
            Log.e(DeviceInfo.TAG, "Missing cache dir");
            return null;
        }

        String storage  = dir.toString() + "/DeviceInfo";

        new File(storage).mkdir();

        return new File(storage, name);
    }
}
