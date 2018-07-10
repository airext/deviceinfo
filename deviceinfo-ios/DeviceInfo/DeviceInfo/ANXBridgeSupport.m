//
//  ANXBridgeSupport.m
//  DeviceInfo
//
//  Created by Max Rozdobudko on 12/2/17.
//  Copyright © 2017 Max Rozdobudko. All rights reserved.
//

#import "ANXBridgeSupport.h"
#import "ANXDeviceInfoConversionRoutines.h"

@implementation ANXDeviceInfoVO {
    NSNumber* _integerValue;
    NSNumber* _booleanValue;
}

+ (id)valueObjectWithInteger:(NSInteger)value {
    return [[ANXDeviceInfoVO alloc] initWithInteger:value];
}
+ (id)valueObjectWithBoolean:(BOOL)value {
    return [[ANXDeviceInfoVO alloc] initWithBoolean:value];
}

- (id)initWithInteger:(NSInteger)value {
    if ([super init]) {
        _integerValue = [NSNumber numberWithInteger:value];
    }
    return self;
}
- (id)initWithBoolean:(BOOL)value {
    if ([super init]) {
        _booleanValue = [NSNumber numberWithBool:value];
    }
    return self;
}

- (FREObject)toFREObject {
    if (_integerValue != nil) {
        return [ANXDeviceInfoConversionRoutines convertNSIntegerToFREObject:[_integerValue integerValue]];
    } else if (_booleanValue) {
        return [ANXDeviceInfoConversionRoutines convertBoolToFREObject:[_booleanValue boolValue]];
    } else {
        return NULL;
    }
}

@end
