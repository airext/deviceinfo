package com.github.airext.deviceinfo.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.github.airext.deviceinfo.managers.NotificationCenter;

/**
 * Created by max on 12/6/17.
 */

public class NotificationCenterCanOpenSettingsFunction implements com.adobe.fre.FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        try {
            return FREObject.newObject(NotificationCenter.canOpenSettings(context.getActivity()));
        } catch (FREWrongThreadException e) {
            e.printStackTrace();
        }
        return null;
    }
}
