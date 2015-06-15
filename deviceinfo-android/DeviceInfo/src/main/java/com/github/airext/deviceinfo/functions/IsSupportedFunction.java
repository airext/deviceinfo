package com.github.airext.deviceinfo.functions;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

/**
 * Created by Max Rozdobudko on 6/15/15.
 */
public class IsSupportedFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        try
        {
            return FREObject.newObject(true);
        }
        catch (Exception e)
        {
            e.printStackTrace();

            return null;
        }
    }
}
