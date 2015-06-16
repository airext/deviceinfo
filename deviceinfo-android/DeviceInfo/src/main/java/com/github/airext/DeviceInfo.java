package com.github.airext;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.github.airext.deviceinfo.ExtensionContext;

public class DeviceInfo implements FREExtension
{
    //--------------------------------------------------------------------------
    //
    //  Class variables
    //
    //--------------------------------------------------------------------------

    private static FREContext context;

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static void dispatch(String code, String level)
    {
        context.dispatchStatusEventAsync(code, level);
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    @Override
    public void initialize()
    {
        Log.i("DeviceInfo", "initialize");
    }

    @Override
    public FREContext createContext(String s)
    {
        Log.i("DeviceInfo", "createContext");

        context = new ExtensionContext();

        return context;
    }

    @Override
    public void dispose()
    {
        Log.i("DeviceInfo", "dispose");
    }
}
