//
//  ANXDeviceInfoBattery.h
//  DeviceInfo
//
//  Created by Max Rozdobudko on 10/24/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "ANXDeviceInfo.h"

@interface ANXDeviceInfoBattery : NSObject

+(float) getBatteryLevel;

+(NSString *) getBatteryState;

+(void) startMonitoring;

+(void) stopMonitoring;

@end
