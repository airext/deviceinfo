package com.github.airext.deviceinfo.providers;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.support.annotation.NonNull;
import android.util.Log;
import com.github.airext.DeviceInfo;

import java.text.DecimalFormat;

/**
 * Created by Max Rozdobudko on 6/16/15.
 */
public class DeviceInfoBattery
{
    //--------------------------------------------------------------------------
    //
    //  Class variables
    //
    //--------------------------------------------------------------------------

    private static BatteryChangedReceiver receiver;

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  Class methods: Public API
    //-------------------------------------

    public static void startMonitoring(Activity activity)
    {
        if (!isMonitoring())
        {
            IntentFilter batteryLevelFilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);

            receiver = new BatteryChangedReceiver();

            activity.registerReceiver(receiver, batteryLevelFilter);
        }
    }

    public static void stopMonitoring(Activity activity)
    {
        if (isMonitoring())
        {
            activity.unregisterReceiver(receiver);

            receiver = null;
        }
    }

    public static boolean isMonitoring()
    {
        return receiver != null;
    }

    @NonNull
    public static String getState(Activity activity)
    {
        IntentFilter filter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);

        Intent batteryStatus = activity.getApplicationContext().registerReceiver(null, filter);

        int status = batteryStatus.getIntExtra(BatteryManager.EXTRA_STATUS, BatteryManager.BATTERY_STATUS_UNKNOWN);

        return convertState(status);
    }

    public static String getLevel(Activity activity)
    {
        IntentFilter filter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);

        Intent batteryStatus = activity.getApplicationContext().registerReceiver(null, filter);

        int level = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
        int scale = batteryStatus.getIntExtra(BatteryManager.EXTRA_SCALE, -1);

        return convertLevel(level, scale);
    }

    //-------------------------------------
    //  Class methods: Public API
    //-------------------------------------

    @NonNull
    private static String convertState(int status)
    {
        switch (status)
        {
            case BatteryManager.BATTERY_STATUS_CHARGING :
                return "charging";

            case BatteryManager.BATTERY_STATUS_FULL :
                return "full";

            case BatteryManager.BATTERY_STATUS_NOT_CHARGING :
                return "unplugged";

            case BatteryManager.BATTERY_STATUS_DISCHARGING :
                return "unplugged";

            case BatteryManager.BATTERY_STATUS_UNKNOWN :
            default :
                return "unknown";
        }
    }

    private static String convertLevel(int level, int scale)
    {
        Log.w("DeviceInfo", "convertLevel:" + level + "/" + scale);

        String value = new DecimalFormat("0.0").format(((float) level / (float) scale));

        Log.w("DeviceInfo", "convertLevel:" + level + "/" + scale + "=" + value);

        return value;
    }

    //--------------------------------------------------------------------------
    //
    //  Internal classes
    //
    //--------------------------------------------------------------------------

    static class BatteryChangedReceiver extends BroadcastReceiver
    {
        @Override
        public void onReceive(Context context, Intent intent)
        {
            int level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
            int scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
            int status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1);

            DeviceInfo.dispatch("DeviceInfo.Battery.State.Change", DeviceInfoBattery.convertState(status));
            DeviceInfo.dispatch("DeviceInfo.Battery.Level.Change", DeviceInfoBattery.convertLevel(level, scale));
        }
    }
}
