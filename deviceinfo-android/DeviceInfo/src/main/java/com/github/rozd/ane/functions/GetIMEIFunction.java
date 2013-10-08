package com.github.rozd.ane.functions;

import android.app.Activity;
import android.content.Context;
import android.telephony.TelephonyManager;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * Created by max on 10/7/13.
 */
public class GetIMEIFunction implements FREFunction
{

    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        FREObject result = null;

        Context context = freContext.getActivity().getApplicationContext();

        TelephonyManager manager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);

        try
        {
            result = FREObject.newObject(manager.getDeviceId());
        }
        catch (FREWrongThreadException e)
        {
            Log.w("DeviceInfo", e.toString());
        }

        return result;
    }
}
