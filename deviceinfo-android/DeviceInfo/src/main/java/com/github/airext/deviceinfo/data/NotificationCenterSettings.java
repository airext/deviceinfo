package com.github.airext.deviceinfo.data;

import com.adobe.fre.*;
import com.github.airext.bridge.CallResultValue;

/**
 * Created by max on 1/19/18.
 */

public class NotificationCenterSettings implements CallResultValue {

    public NotificationCenterSettings(String authorizationStatus) {
        super();
        this.authorizationStatus = authorizationStatus;
    }

    private String authorizationStatus;
    public String getAuthorizationStatus() {
        return authorizationStatus;
    }

    @Override
    public FREObject toFREObject() throws FRETypeMismatchException, FREInvalidObjectException, FREWrongThreadException, IllegalStateException {
        try {
            FREObject settings = FREObject.newObject("com.github.airext.notification.NotificationCenterSettings", null);
            settings.setProperty("authorizationStatus", FREObject.newObject(getAuthorizationStatus()));
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