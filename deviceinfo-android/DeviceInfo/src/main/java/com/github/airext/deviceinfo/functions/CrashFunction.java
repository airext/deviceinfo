package com.github.airext.deviceinfo.functions;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * Created by Max Rozdobudko on 7/20/15.
 */
public class CrashFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects) {
        Log.d("ANXDeviceInfo", "CrashFunction");

        stackOverflow();

        int[] array = new int[0];

        int result = array[1];

        try {
            return FREObject.newObject(result);
        } catch (FREWrongThreadException e) {
            e.printStackTrace();
            throw new RuntimeException("This is a crash");
        }
    }

    private void stackOverflow() {
        stackOverflow();
    }
}
