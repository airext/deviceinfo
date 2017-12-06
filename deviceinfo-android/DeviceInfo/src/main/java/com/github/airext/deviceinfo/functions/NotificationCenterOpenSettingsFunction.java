package com.github.airext.deviceinfo.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.github.airext.deviceinfo.managers.NotificationCenter;

/**
 * Created by max on 12/6/17.
 */

public class NotificationCenterOpenSettingsFunction implements com.adobe.fre.FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        NotificationCenter.openSettings(context.getActivity());
        return null;
    }
}
