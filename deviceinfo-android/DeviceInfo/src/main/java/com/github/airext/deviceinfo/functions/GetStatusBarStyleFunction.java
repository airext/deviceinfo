package com.github.airext.deviceinfo.functions;

import android.app.Activity;
import android.os.Build;
import android.view.View;
import android.view.Window;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * Created by max on 5/28/17.
 */

public class GetStatusBarStyleFunction implements com.adobe.fre.FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        Activity activity = context.getActivity();
        Window window = activity.getWindow();

        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                if ((window.getDecorView().getSystemUiVisibility() & View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR) > 0) {
                    return FREObject.newObject("light"); // meaning light content
                } else {
                    return FREObject.newObject("default");
                }
            }
            return  FREObject.newObject("unknown");
        } catch (FREWrongThreadException e) {
            e.printStackTrace();
        }

        return null;
    }
}
