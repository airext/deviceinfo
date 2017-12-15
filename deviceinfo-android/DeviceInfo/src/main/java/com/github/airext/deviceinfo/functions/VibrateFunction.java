package com.github.airext.deviceinfo.functions;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Vibrator;
import android.util.Log;
import com.adobe.fre.*;

/**
 * Created by max on 12/15/17.
 */

public class VibrateFunction implements com.adobe.fre.FREFunction {

    @SuppressLint("MissingPermission")
    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        Log.i ("ANXDeviceInfo", "VibrateFunction");

        Vibrator vibrator = (Vibrator) context.getActivity().getSystemService(Context.VIBRATOR_SERVICE);

        int duration = 0;
        try {
            duration = args[0].getAsInt();

        } catch (Exception e) {
            e.printStackTrace();
        }

        vibrator.vibrate(duration);

        return null;
    }
}
