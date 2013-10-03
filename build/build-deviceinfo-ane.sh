#!/bin/bash

unzip -o deviceinfo.swc

unzip -o default/deviceinfo-default.swc -d default

adt -package -storetype pkcs12 -keystore ~/certs/rozd.p12 -storepass vopli -target ane deviceinfo.ane extension.xml -swc deviceinfo.swc -platform iPhone-ARM library.swf libDeviceInfo.a -platformoptions platform.xml -platform default -C default library.swf

cp -R deviceinfo.ane ../deviceinfo-air/deviceinfo-debug/ane/deviceinfo.ane

cp -R deviceinfo.ane ../bin/deviceinfo.ane

mkdir -p launch/ext
cp -R deviceinfo.ane launch/ext/deviceinfo.ane
unzip -o launch/ext/deviceinfo.ane -d launch/ext

rm library.swf
rm catalog.xml

rm default/library.swf
rm default/catalog.xml