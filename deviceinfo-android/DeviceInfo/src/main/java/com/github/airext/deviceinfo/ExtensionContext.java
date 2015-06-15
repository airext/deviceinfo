package com.github.airext.deviceinfo;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.github.airext.deviceinfo.functions.GetAndroidIdentifierFunction;
import com.github.airext.deviceinfo.functions.GetGeneralInfoFunction;
import com.github.airext.deviceinfo.functions.GetIMEIFunction;
import com.github.airext.deviceinfo.functions.IsSupportedFunction;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Max Rozdobudko on 6/15/15.
 */
public class ExtensionContext extends FREContext
{
    @Override
    public Map<String, FREFunction> getFunctions()
    {
        Map<String, FREFunction> functions = new HashMap<String, FREFunction>();

        functions.put("isSupported", new IsSupportedFunction());
        functions.put("getGeneralInfo", new GetGeneralInfoFunction());
        functions.put("getIMEI", new GetIMEIFunction());

        functions.put("getAndroidIdentifier", new GetAndroidIdentifierFunction());

        return functions;
    }

    @Override
    public void dispose()
    {

    }
}
