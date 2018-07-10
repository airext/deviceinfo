package com.github.airext.deviceinfo.functions;

import android.app.Activity;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.github.airext.deviceinfo.utils.Resources;
import com.github.airext.deviceinfo.utils.ConversionRoutines;

/**
 * Created by max on 12/7/17.
 */

public class ThemeSetStyleFunction implements com.adobe.fre.FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        Activity activity = context.getActivity();

        int newThemeId = ConversionRoutines.readIntPropertyFrom(args[0], "rawValue", -1);

        if (newThemeId == -1) {
            newThemeId = Resources.getResourseIdByName(activity.getPackageName(), "style", "Theme_NoShadow");
        }

        activity.setTheme(newThemeId);

        return null;
    }
}
