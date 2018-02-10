package com.github.airext.deviceinfo.utils;

import android.content.Context;

import java.io.*;

/**
 * Created by max on 2/10/18.
 */

public class AssetsUtil {

    public static File copyAssetToTempFileIfNeeded(Context context, String assetFilePath) {
        File temp = CacheUtil.getFile(context, assetFilePath);

        if (temp == null) {
            return null;
        }

        if (temp.exists()) {
            return temp;
        }

        try {
            InputStream input = context.getAssets().open(assetFilePath);
            FileOutputStream out = new FileOutputStream(temp);
            copyFile(input, out);
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }

        return temp;
    }

    private static void copyFile(InputStream in, OutputStream out) throws IOException {
        byte[] buffer = new byte[1024];
        int read;

        while ((read = in.read(buffer)) != -1) {
            out.write(buffer, 0, read);
        }
    }
}
