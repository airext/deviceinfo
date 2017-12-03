package com.github.airext.deviceinfo.functions;

import com.adobe.fre.*;
import com.github.airext.bridge.Bridge;
import com.github.airext.bridge.Call;

/**
 * Created by max on 12/3/17.
 */

public class DismissAlertFunction implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        if (PresentAlertFunction.currentAlert != null) {
            PresentAlertFunction.currentAlert.dismiss();
            PresentAlertFunction.currentAlert = null;
        }

        if (args.length > 0) {
            try {
                int callId = args[0].getAsInt();
                Call call = Bridge.callWithId(callId);
                call.cancel();
            } catch (FRETypeMismatchException e) {
                e.printStackTrace();
            } catch (FREInvalidObjectException e) {
                e.printStackTrace();
            } catch (FREWrongThreadException e) {
                e.printStackTrace();
            }
        }

        return null;
    }
}
