package com.github.rozd.ane.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * Created by max on 10/7/13.
 */
public class IsSupportedFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        FREObject result = null;

        try
        {
            result = FREObject.newObject(true);
        }
        catch (FREWrongThreadException e)
        {
            Log.w("DeviceInfo", e.toString());
        }

        return result;
    }
}
