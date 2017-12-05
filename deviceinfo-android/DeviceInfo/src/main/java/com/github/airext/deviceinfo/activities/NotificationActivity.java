package com.github.airext.deviceinfo.activities;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import com.github.airext.deviceinfo.managers.NotificationCenter;

/**
 * Created by max on 12/5/17.
 */

public class NotificationActivity extends Activity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        NotificationCenter.handleNotificationReceived(getApplicationContext(), getIntent());

        try {
            Intent intent = new Intent(getApplicationContext(), Class.forName(getPackageName() + ".AppEntry"));
            startActivity(intent);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        finish();
    }
}
