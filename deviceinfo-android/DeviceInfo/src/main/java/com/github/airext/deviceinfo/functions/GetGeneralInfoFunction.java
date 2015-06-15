package com.github.airext.deviceinfo.functions;

import android.bluetooth.BluetoothAdapter;
import android.os.Build;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

/**
 * Created by Max Rozdobudko on 6/12/15.
 */
public class GetGeneralInfoFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        try
        {
            FREObject info = FREObject.newObject("com.github.airext.data.DeviceInfoGeneral", null);

            if (BluetoothAdapter.getDefaultAdapter() != null)
                info.setProperty("name", FREObject.newObject(BluetoothAdapter.getDefaultAdapter().getName()));

            info.setProperty("model", FREObject.newObject(Build.MODEL));
            info.setProperty("systemName", FREObject.newObject("Android"));
            info.setProperty("systemVersion", FREObject.newObject(Build.VERSION.RELEASE));
            info.setProperty("manufacturer", FREObject.newObject(Build.MANUFACTURER));
            info.setProperty("platform", FREObject.newObject("android"));

            return info;
        }
        catch (Exception e)
        {
            e.printStackTrace();

            return null;
        }
    }
}
