package com.github.airext.deviceinfo.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * Created by max on 12/7/17.
 */

public class ThemeIsSupportedFunction implements com.adobe.fre.FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        try {
            return FREObject.newObject(true);
        } catch (FREWrongThreadException e) {
            e.printStackTrace();
        }

        return null;
    }
}
