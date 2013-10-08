#!/bin/bash

cp -R ../deviceinfo-air/deviceinfo-debug/bin-debug/DeviceInfoDebug-app.xml launch/DeviceInfoDebug-app.xml
cp -R ../deviceinfo-air/deviceinfo-debug/bin-debug/DeviceInfoDebug.swf launch/DeviceInfoDebug.swf

adt -package -target apk -storetype pkcs12 -keystore log5f.p12 -storepass vopli launch/DeviceInfoDebug.apk launch/DeviceInfoDebug-app.xml -extdir launch/ext -C launch DeviceInfoDebug.swf