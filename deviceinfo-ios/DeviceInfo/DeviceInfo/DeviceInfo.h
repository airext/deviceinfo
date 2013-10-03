//
//  DeviceInfo.h
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FlashRuntimeExtensions.h"

#import "FRETypeConversion.h"

@interface DeviceInfo : NSObject

+(DeviceInfo*) sharedInstance;

- (NSString*) getIMEI;

@end