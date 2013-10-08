package com.github.rozd.ane.functions;

import android.bluetooth.BluetoothAdapter;
import android.os.Build;

import com.adobe.fre.FREASErrorException;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FRENoSuchNameException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

/**
 * Created by max on 10/7/13.
 */
public class GetDeviceInfoFnciton implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        FREObject result = null;

        try
        {
            result = FREObject.newObject("Object", null);

            if (BluetoothAdapter.getDefaultAdapter() != null)
                result.setProperty("name", FREObject.newObject(BluetoothAdapter.getDefaultAdapter().getName()));

            result.setProperty("model", FREObject.newObject(Build.MODEL));
            result.setProperty("systemName", FREObject.newObject("Android"));
            result.setProperty("systemVersion", FREObject.newObject(Build.VERSION.RELEASE));
            result.setProperty("manufacturer", FREObject.newObject(Build.MANUFACTURER));
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return result;
    }
}
