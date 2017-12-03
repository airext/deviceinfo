//
//  ANXBridgeSupport.h
//  DeviceInfo
//
//  Created by Max Rozdobudko on 12/2/17.
//  Copyright © 2017 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

@interface ANXDeviceInfoIntegerVO : NSObject

- (id)initWithValue:(NSInteger)value;

- (FREObject)toFREObject;

@end
