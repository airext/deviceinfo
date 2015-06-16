package com.github.airext.deviceinfo.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.github.airext.deviceinfo.providers.DeviceInfoBattery;

/**
 * Created by Max Rozdobudko on 6/16/15.
 */
public class StopBatteryMonitorFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        DeviceInfoBattery.stopMonitoring(freContext.getActivity());

        return null;
    }
}
