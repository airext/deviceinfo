package com.github.rozd.ane;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.github.rozd.ane.functions.GetDeviceInfoFnciton;
import com.github.rozd.ane.functions.GetIMEIFunction;
import com.github.rozd.ane.functions.GetPlatformFunction;
import com.github.rozd.ane.functions.IsSupportedFunction;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by max on 10/7/13.
 */
public class DeviceInfoContext extends FREContext
{
    @Override
    public Map<String, FREFunction> getFunctions()
    {
        Map<String, FREFunction> functions = new HashMap<String, FREFunction>();

        functions.put("isSupported", new IsSupportedFunction());
        functions.put("getIMEI", new GetIMEIFunction());
        functions.put("getDeviceInfo", new GetDeviceInfoFnciton());
        functions.put("getPlatform", new GetPlatformFunction());

        return functions;
    }

    @Override
    public void dispose()
    {

    }
}
