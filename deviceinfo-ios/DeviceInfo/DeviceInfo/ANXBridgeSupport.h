//
//  ANXBridgeSupport.h
//  DeviceInfo
//
//  Created by Max Rozdobudko on 12/2/17.
//  Copyright © 2017 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

@interface ANXDeviceInfoVO : NSObject

+ (id)valueObjectWithInteger:(NSInteger)value;
+ (id)valueObjectWithBoolean:(BOOL)value;

- (id)initWithInteger:(NSInteger)value;
- (id)initWithBoolean:(BOOL)value;

- (FREObject)toFREObject;

@end
