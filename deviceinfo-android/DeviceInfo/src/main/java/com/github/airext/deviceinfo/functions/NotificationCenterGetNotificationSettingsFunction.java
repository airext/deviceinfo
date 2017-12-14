package com.github.airext.deviceinfo.functions;

import android.app.Activity;
import com.adobe.fre.*;
import com.github.airext.bridge.Bridge;
import com.github.airext.bridge.Call;
import com.github.airext.bridge.CallResultValue;
import com.github.airext.deviceinfo.managers.NotificationCenter;
import com.github.airext.deviceinfo.utils.DispatchQueue;

/**
 * Created by max on 12/3/17.
 */

public class NotificationCenterGetNotificationSettingsFunction implements FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        Activity activity = context.getActivity();

        final Call call = Bridge.call(context);

        DispatchQueue.dispatch_async(activity, new Runnable() {
            @Override
            public void run() {
                call.result(new NotificationCenterSettingsVO());
            }
        });

        return call.toFREObject();
    }
}

class NotificationCenterSettingsVO implements CallResultValue {

    public NotificationCenterSettingsVO() {
        super();
    }

    @Override
    public FREObject toFREObject() throws FRETypeMismatchException, FREInvalidObjectException, FREWrongThreadException, IllegalStateException {
        try {
            FREObject settings = FREObject.newObject("com.github.airext.notification.NotificationCenterSettings", null);
            settings.setProperty("authorizationStatus", FREObject.newObject("granted"));
            return settings;
        } catch (FREASErrorException e) {
            e.printStackTrace();
        } catch (FRENoSuchNameException e) {
            e.printStackTrace();
        } catch (FREReadOnlyException e) {
            e.printStackTrace();
        }
        return null;
    }
}