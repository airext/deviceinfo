//
//  ANXDeviceInfoGeneralProvider.h
//  DeviceInfo
//
//  Created by Max Rozdobudko on 10/23/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "FlashRuntimeExtensions.h"

@interface ANXDeviceInfoGeneralProvider : NSObject

+(FREObject) getGeneralInfo;

@end
