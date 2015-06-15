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
public class GetBatteryStateFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        IntentFilter filter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);

        Intent batteryStatus = freContext.getActivity().getApplicationContext().registerReceiver(null, filter);

        int status = batteryStatus.getIntExtra(BatteryManager.EXTRA_STATUS, BatteryManager.BATTERY_STATUS_UNKNOWN);

        try
        {
            switch (status)
            {
                case BatteryManager.BATTERY_STATUS_CHARGING : return FREObject.newObject("charging");
                case BatteryManager.BATTERY_STATUS_FULL : return FREObject.newObject("full");
                case BatteryManager.BATTERY_STATUS_NOT_CHARGING : return FREObject.newObject("unplugged");
                case BatteryManager.BATTERY_STATUS_DISCHARGING : return FREObject.newObject("unplugged");
                case BatteryManager.BATTERY_STATUS_UNKNOWN : default : return FREObject.newObject("unknown");
            }
        }
        catch (FREWrongThreadException e)
        {
            e.printStackTrace();
        }

        return null;
    }
}
