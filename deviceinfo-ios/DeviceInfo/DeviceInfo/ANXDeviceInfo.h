//
//  DeviceInfo.h
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "FlashRuntimeExtensions.h"

#import "ANXDeviceInfoConversionRoutines.h"

@interface ANXDeviceInfo : NSObject

+ (ANXDeviceInfo*) sharedInstance;

- (NSString*) getIMEI;

- (NSDictionary*) getDeviceInfo;

- (NSString*) getDeviceIdentifier;

@end