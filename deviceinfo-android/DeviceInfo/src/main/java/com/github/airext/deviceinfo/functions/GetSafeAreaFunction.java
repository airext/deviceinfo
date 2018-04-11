package com.github.airext.deviceinfo.functions;

import android.app.Activity;
import android.support.v4.view.ViewCompat;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

/**
 * Created by max on 3/11/18.
 */

public class GetSafeAreaFunction implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        Activity activity = context.getActivity();

//        ViewCompat.onApplyWindowInsets()
//
//        FREObject top = FREObject.newObject(activity.view)

//        FREObject insets = FREObject.newObject()

        // TODO: Not yet implemented
        return null;
    }
}
