package com.github.airext;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.github.airext.deviceinfo.ExtensionContext;

public class DeviceInfo implements FREExtension
{
    @Override
    public void initialize()
    {
        Log.i("DeviceInfo", "initialize");
    }

    @Override
    public FREContext createContext(String s)
    {
        Log.i("DeviceInfo", "createContext");

        return new ExtensionContext();
    }

    @Override
    public void dispose()
    {
        Log.i("DeviceInfo", "dispose");
    }
}
