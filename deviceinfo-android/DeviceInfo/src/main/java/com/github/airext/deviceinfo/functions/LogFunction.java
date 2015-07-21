package com.github.airext.deviceinfo.functions;

import android.util.Log;
import com.adobe.fre.*;

/**
 * Created by Max Rozdobudko on 7/20/15.
 */
public class LogFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext context, FREObject[] args)
    {
        if (args.length == 2)
        {
            try
            {
                Log.w(args[0].getAsString(), args[1].getAsString());
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        }

        return null;
    }
}
