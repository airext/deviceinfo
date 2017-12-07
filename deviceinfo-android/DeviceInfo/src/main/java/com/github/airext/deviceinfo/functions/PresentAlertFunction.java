package com.github.airext.deviceinfo.functions;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.pm.PackageManager;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.text.Html;
import android.util.Log;
import com.adobe.fre.*;
import com.github.airext.bridge.Bridge;
import com.github.airext.bridge.Call;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by max on 12/3/17.
 */

public class PresentAlertFunction implements FREFunction {

    private static final String TAG = "AlertController";

    public static AlertDialog currentAlert = null;

    int getThemeId(Context context) {
        try {
            Class<?> wrapper = Context.class;
            Method method = wrapper.getMethod("getThemeResId");
            method.setAccessible(true);
            return (Integer) method.invoke(context);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        Log.d(TAG, "PresentAlertFunction");

        Activity activity = context.getActivity();

        Log.i(TAG, String.valueOf(activity.getApplicationInfo().theme));
        Log.i(TAG, String.valueOf(getThemeId(activity)));

        try {
            Log.i(TAG, String.valueOf(activity.getPackageManager().getActivityInfo(activity.getComponentName(), 0).theme));
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }

        Log.i(TAG, "");

        String title = null;
        String message = null;
        int style = 0;
        ArrayList<ActionDescriptor> actionDescriptors = new ArrayList<ActionDescriptor>();

        try {
            if (args[0] != null) {
                title = args[0].getAsString();
            }
            if (args[1] != null) {
                message = args[1].getAsString();
            }
            if (args[2] != null) {
                style = args[2].getProperty("rawValue").getAsInt();
            }
            if (args.length > 3) {
                actionDescriptors = ActionDescriptor.fromFREArray((FREArray) args[3]);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        final Call call = Bridge.call(context);

        AlertDialog.Builder builder = new AlertDialog.Builder(activity);
        if (title != null && !title.equals("")) {
            builder.setTitle(Html.fromHtml(title));
        }
        if (message != null && !message.equals("")) {
            builder.setMessage(message);
        }

        final ActionDescriptor cancellationAction = ActionDescriptor.findCancellationAction(actionDescriptors);
        if (cancellationAction != null) {
            builder.setNeutralButton(cancellationAction.getTitle(), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    call.result(cancellationAction.getIndex());
                }
            });
            builder.setCancelable(true);
            builder.setOnCancelListener(new DialogInterface.OnCancelListener() {
                @Override
                public void onCancel(DialogInterface dialogInterface) {
                    call.result(cancellationAction.getIndex());
                }
            });
        }

        final ActionDescriptor defaultAction = ActionDescriptor.findDefaultAction(actionDescriptors);
        if (defaultAction != null) {
            builder.setPositiveButton(defaultAction.getTitle(), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    call.result(defaultAction.getIndex());
                }
            });
        }

        final ActionDescriptor destructiveAction = ActionDescriptor.findDestructiveAction(actionDescriptors);
        if (destructiveAction != null) {
            builder.setNegativeButton(destructiveAction.getTitle(), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    call.result(destructiveAction.getIndex());
                }
            });
        }

        final AlertDialog alert = builder.create();
        alert.setCanceledOnTouchOutside(cancellationAction != null);
        alert.setOnDismissListener(new DialogInterface.OnDismissListener() {
            @Override
            public void onDismiss(DialogInterface dialogInterface) {
                if (currentAlert == alert) {
                    currentAlert = null;
                }
            }
        });
        alert.show();
        currentAlert = alert;

        if (defaultAction != null && !defaultAction.isEnabled()) {
            alert.getButton(AlertDialog.BUTTON_POSITIVE).setEnabled(false);
        }
        if (destructiveAction != null && !destructiveAction.isEnabled()) {
            alert.getButton(AlertDialog.BUTTON_NEGATIVE).setEnabled(false);
        }

        return call.toFREObject();
    }
}

class ActionDescriptor {

    static int styleDefault = 0;
    static int styleCancellation = 1;
    static int styleDestructive = 2;

    @Nullable
    public static ActionDescriptor findDefaultAction(ArrayList<ActionDescriptor> descriptors) {
        for (ActionDescriptor descriptor : descriptors) {
            if (descriptor.isDefault()) {
                return descriptor;
            }
        }
        return null;
    }

    @Nullable
    public static ActionDescriptor findCancellationAction(ArrayList<ActionDescriptor> descriptors) {
        for (ActionDescriptor descriptor : descriptors) {
            if (descriptor.isCancellation()) {
                return descriptor;
            }
        }
        return null;
    }

    @Nullable
    public static ActionDescriptor findDestructiveAction(ArrayList<ActionDescriptor> descriptors) {
        for (ActionDescriptor descriptor : descriptors) {
            if (descriptor.isDestructive()) {
                return descriptor;
            }
        }
        return null;
    }

    public static ArrayList<ActionDescriptor> fromFREArray(FREArray array) {
        ArrayList<ActionDescriptor> descriptors = new ArrayList<ActionDescriptor>();
        try {
            for (int i = 0, n = array != null ? (int)array.getLength() : 0; i < n; i++) {
                ActionDescriptor descriptor = new ActionDescriptor(array.getObjectAt(i));
                descriptor.setIndex(i);
                descriptors.add(descriptor);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  descriptors;
    }

    public ActionDescriptor(FREObject action) {
        super();

        try {
            title = action.getProperty("title").getAsString();
            style = action.getProperty("style").getProperty("rawValue").getAsInt();
            enabled = action.getProperty("isEnabled").getAsBool();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String title;
    public String getTitle() {
        return title;
    }

    private int style;
    public int getStyle() {
        return style;
    }

    private Boolean enabled;
    public Boolean isEnabled() {
        return enabled;
    }

    public Boolean isDefault() {
        return style == styleDefault;
    }
    public Boolean isDestructive() {
        return style == styleDestructive;
    }
    public Boolean isCancellation() {
        return style == styleCancellation;
    }

    public int index;
    public int getIndex() {
        return index;
    }
    public void setIndex(int index) {
        this.index = index;
    }
}