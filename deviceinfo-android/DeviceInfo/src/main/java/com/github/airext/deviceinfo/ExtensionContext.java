package com.github.airext.deviceinfo;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.github.airext.bridge.Bridge;
import com.github.airext.bridge.exceptions.BridgeInstantiationException;
import com.github.airext.bridge.exceptions.BridgeNotFoundException;
import com.github.airext.deviceinfo.functions.*;

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

        functions.put("getBatteryLevel", new GetBatteryLevelFunction());
        functions.put("getBatteryState", new GetBatteryStateFunction());
        functions.put("startBatteryMonitor", new StartBatteryMonitorFunction());
        functions.put("stopBatteryMonitor", new StopBatteryMonitorFunction());

        functions.put("getAndroidIdentifier", new GetAndroidIdentifierFunction());

        functions.put("log", new LogFunction());
        functions.put("crash", new CrashFunction());

        functions.put("setStatusBarStyle", new SetStatusBarStyleFunction());
        functions.put("getStatusBarStyle", new GetStatusBarStyleFunction());

        functions.put("presentAlert", new PresentAlertFunction());
        functions.put("dismissAlert", new DismissAlertFunction());

        functions.put("notificationCenterIsSupported", new NotificationCenterIsSupportedFunction());
        functions.put("notificationCenterPermissionStatus", new NotificationCenterPermissionStatusFunction());
        functions.put("notificationCenterRequestPermission", new NotificationCenterRequestPermissionFunction());
        functions.put("notificationCenterAddRequest", new NotificationCenterAddRequestFunction());
        functions.put("notificationCenterRemovePendingNotificationRequests", new NotificationCenterRemovePendingNotificationRequestsFunction());
        functions.put("notificationCenterRemoveAllPendingNotificationRequests", new NotificationCenterRemoveAllPendingNotificationRequestsFunction());
        functions.put("notificationCenterInBackground", new NotificationCenterInBackgroundFunction());
        functions.put("notificationCenterInForeground", new NotificationCenterInForegroundFunction());
        functions.put("notificationCenterIsEnabled", new NotificationCenterIsEnabledFunction());
        functions.put("notificationCenterCanOpenSettings", new NotificationCenterCanOpenSettingsFunction());
        functions.put("notificationCenterOpenSettings", new NotificationCenterOpenSettingsFunction());

        functions.put("themeIsSupported", new ThemeIsSupportedFunction());
        functions.put("themeSetStyle", new ThemeSetStyleFunction());

        try {
            Bridge.setup(functions);
        } catch (BridgeNotFoundException e) {
            e.printStackTrace();
        } catch (BridgeInstantiationException e) {
            e.printStackTrace();
        }

        return functions;
    }

    @Override
    public void dispose()
    {

    }
}
