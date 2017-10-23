package com.github.airext.deviceinfo.functions;

import android.app.Activity;
import android.os.Build;
import android.view.View;
import android.view.Window;
import com.adobe.fre.*;

/**
 * Created by max on 5/28/17.
 */

public class SetStatusBarStyleFunction implements FREFunction {
    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        try {
            String style = args[0].getAsString();

            Activity activity = context.getActivity();
            Window window = activity.getWindow();

            if (style.equals("light")) { // meaning light content
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    window.getDecorView().setSystemUiVisibility(window.getDecorView().getSystemUiVisibility() ^ View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
                }
            } else if (style.equals("default")) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    window.getDecorView().setSystemUiVisibility(window.getDecorView().getSystemUiVisibility() | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
                }
            }

        } catch (FRETypeMismatchException e) {
            e.printStackTrace();
        } catch (FREInvalidObjectException e) {
            e.printStackTrace();
        } catch (FREWrongThreadException e) {
            e.printStackTrace();
        }
        return null;
    }
}
