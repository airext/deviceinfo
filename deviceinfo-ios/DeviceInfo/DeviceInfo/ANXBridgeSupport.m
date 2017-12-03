//
//  ANXBridgeSupport.m
//  DeviceInfo
//
//  Created by Max Rozdobudko on 12/2/17.
//  Copyright © 2017 Max Rozdobudko. All rights reserved.
//

#import "ANXBridgeSupport.h"
#import "ANXDeviceInfoConversionRoutines.h"

@implementation ANXDeviceInfoIntegerVO {
    NSInteger _value;
}

+ (id)valueObjectWithInteger:(NSInteger)value {
    return [[ANXDeviceInfoIntegerVO alloc] initWithValue:value];
}

- (id)initWithValue:(NSInteger)value {
    if ([super init]) {
        _value = value;
    }
    return self;
}

- (FREObject)toFREObject {
    return [ANXDeviceInfoConversionRoutines convertNSIntegerToFREObject:_value];
}

@end

