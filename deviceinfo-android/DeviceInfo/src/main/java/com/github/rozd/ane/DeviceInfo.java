package com.github.rozd.ane;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

/**
 * Created by max on 10/7/13.
 */
public class DeviceInfo implements FREExtension
{
    public DeviceInfo()
    {
        Log.d("DeviceInfo", "DeviceInfo");
    }

    @Override
    public void initialize()
    {

    }

    @Override
    public FREContext createContext(String s)
    {
        return new DeviceInfoContext();
    }

    @Override
    public void dispose()
    {

    }
}
