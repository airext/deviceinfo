package com.github.airext.deviceinfo.functions;

import android.content.Context;
import android.provider.Settings.Secure;
import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * Created by max on 10/22/13.
 */
public class GetAndroidIdentifierFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        FREObject result = null;

        try
        {
            Context context = freContext.getActivity().getApplicationContext();

            String id = Secure.getString(context.getContentResolver(), Secure.ANDROID_ID);

            result = FREObject.newObject(id);
        }
        catch (FREWrongThreadException e)
        {
            e.printStackTrace();
        }

        return result;
    }
}
