package com.github.airext.deviceinfo.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.github.airext.deviceinfo.providers.DeviceInfoBattery;

/**
 * Created by Max Rozdobudko on 6/15/15.
 */
public class GetBatteryLevelFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        String level = DeviceInfoBattery.getLevel(freContext.getActivity());

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
