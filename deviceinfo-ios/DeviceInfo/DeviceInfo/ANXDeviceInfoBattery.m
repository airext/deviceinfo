//
//  ANXDeviceInfoBattery.m
//  DeviceInfo
//
//  Created by Max Rozdobudko on 10/24/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import "ANXDeviceInfoBattery.h"

@implementation ANXDeviceInfoBattery

BOOL isMonitoring = NO;

id batteryStateChangeObserver;

id batteryLevelChangeObserver;

+(float) getBatteryLevel
{
    UIDevice *device = [UIDevice currentDevice];
    
    float batteryLevel = 0.0;
    
    if (device.isBatteryMonitoringEnabled)
    {
        batteryLevel = device.batteryLevel;
    }
    else
    {
        [device setBatteryMonitoringEnabled:YES];
            
        batteryLevel = device.batteryLevel;
            
        [device setBatteryMonitoringEnabled:NO];
        
    }
    
    return batteryLevel;
}

+(NSString *) getBatteryState
{
    UIDevice *device = [UIDevice currentDevice];

    UIDeviceBatteryState batteryState;
    
    if (device.isBatteryMonitoringEnabled)
    {
        batteryState = device.batteryState;
    }
    else
    {
        [device setBatteryMonitoringEnabled:YES];
            
        batteryState = device.batteryState;
            
        [device setBatteryMonitoringEnabled:NO];
    }
    
    switch (batteryState)
    {
        case UIDeviceBatteryStateCharging:
            return @"charging";
            break;
            
        case UIDeviceBatteryStateFull:
            return @"full";
            break;
            
        case UIDeviceBatteryStateUnplugged:
            return @"unplugged";
            break;
            
        case UIDeviceBatteryStateUnknown :
        default:
            return @"unknown";
            break;
    }
}

+(void) startMonitoring
{
    if (!isMonitoring)
    {
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
        
        batteryStateChangeObserver =
        [[NSNotificationCenter defaultCenter]
            addObserverForName:UIDeviceBatteryStateDidChangeNotification
            object:nil queue:[NSOperationQueue mainQueue]
            usingBlock:^(NSNotification *note)
            {
                [[ANXDeviceInfo sharedInstance] dispatch:@"DeviceInfo.Battery.State" withLevel:[self getBatteryState]];
            }];
        
        
        batteryLevelChangeObserver =
        [[NSNotificationCenter defaultCenter]
            addObserverForName:UIDeviceBatteryLevelDidChangeNotification
            object:nil queue:[NSOperationQueue mainQueue]
            usingBlock:^(NSNotification *note)
            {
                NSString *levelAsString = [NSString stringWithFormat:@"%f", [self getBatteryLevel]];
                
                [[ANXDeviceInfo sharedInstance] dispatch:@"DeviceInfo.Battery.Level" withLevel:levelAsString];
            }];
        
        isMonitoring = YES;
    }
}

+(void) stopMonitoring
{
    if (isMonitoring)
    {
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:NO];
        
        [[NSNotificationCenter defaultCenter] removeObserver:batteryStateChangeObserver];
        [[NSNotificationCenter defaultCenter] removeObserver:batteryLevelChangeObserver];
        
        isMonitoring = NO;
    }
}

@end
