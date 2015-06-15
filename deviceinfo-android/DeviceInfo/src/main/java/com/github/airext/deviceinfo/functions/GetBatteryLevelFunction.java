package com.github.airext.deviceinfo.functions;

import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * Created by Max Rozdobudko on 6/15/15.
 */
public class GetBatteryLevelFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        IntentFilter filter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);

        Intent batteryStatus = freContext.getActivity().getApplicationContext().registerReceiver(null, filter);

        int level = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, 0);

        try
        {
            return FREObject.newObject(level);
        }
        catch (FREWrongThreadException e)
        {
            e.printStackTrace();
        }

        return null;
    }
}
