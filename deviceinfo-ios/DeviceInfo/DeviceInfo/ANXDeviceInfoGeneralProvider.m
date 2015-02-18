//
//  ANXDeviceInfoGeneralProvider.m
//  DeviceInfo
//
//  Created by Max Rozdobudko on 10/23/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import "ANXDeviceInfoGeneralProvider.h"

#import "ANXDeviceInfo.h"

@implementation ANXDeviceInfoGeneralProvider

+(FREObject) getGeneralInfo
{
    @try
    {
        FREResult result;
        
        FREObject info;
        result = FRENewObject((const uint8_t *) "com.github.airext.data.DeviceInfoGeneral", 0, NULL, &info, NULL);
        
        if (result != FRE_OK)
            return NULL;
        
        UIDevice* device = [UIDevice currentDevice];
        
        [ANXDeviceInfoConversionRoutines setStringTo:info withValue:device.name forProperty:@"name"];
        [ANXDeviceInfoConversionRoutines setStringTo:info withValue:device.model forProperty:@"model"];
        [ANXDeviceInfoConversionRoutines setStringTo:info withValue:device.systemName forProperty:@"systemName"];
        [ANXDeviceInfoConversionRoutines setStringTo:info withValue:device.systemVersion forProperty:@"systemVersion"];
        [ANXDeviceInfoConversionRoutines setStringTo:info withValue:@"Apple" forProperty:@"manufacturer"];
                
        return info;
    }
    @catch (NSException *exception)
    {
        [[ANXDeviceInfo sharedInstance] dispatch:@"DeviceInfo.GeneralInfo.Get.Failed" withLevel:[exception description]];
    }
    @finally
    {
        // does nothing
    }
    
    return NULL;
}

@end
