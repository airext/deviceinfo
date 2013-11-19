//
//  DeviceInfo.h
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "CoreTelephony.h"

#import "FlashRuntimeExtensions.h"

#import "DeviceInfo_FRETypeConversion.h"

@interface DeviceInfo : NSObject

+ (DeviceInfo*) sharedInstance;

- (NSString*) getIMEI;

- (NSDictionary*) getDeviceInfo;

- (NSString*) getDeviceIdentifier;

@end