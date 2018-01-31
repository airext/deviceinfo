package com.github.airext.deviceinfo.functions;

import com.adobe.fre.*;
import com.github.anrwatchdog.ANRWatchDog;

/**
 * Created by max on 1/31/18.
 */
public class DebugStartANRWatchdogFunction implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        int timeout = 5000;

        if (args.length > 0) {
            try {
                timeout = args[0].getAsInt();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        new ANRWatchDog(timeout).start();

        return null;
    }
}
