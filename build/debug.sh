#!/bin/bash

cp -R ../deviceinfo-air/deviceinfo-debug/bin-debug/DeviceInfoDebug-app.xml launch/DeviceInfoDebug-app.xml
cp -R ../deviceinfo-air/deviceinfo-debug/bin-debug/DeviceInfoDebug.swf launch/DeviceInfoDebug.swf

adt -package -target ipa-debug-interpreter -provisioning-profile $IOS_PROVISION -storetype pkcs12 -keystore $IOS_CERTIFICATE -storepass $IOS_CERTIFICATE_STOREPASS launch/DeviceInfoDebug.ipa launch/DeviceInfoDebug-app.xml -C launch DeviceInfoDebug.swf -extdir launch/ext -platformsdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/