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

@implementation ANXNotificationCenterSettingsVO {
    NSString* _authorizationStatus;
}

- (id)initWithAuthorizationStatus:(NSString*)authorizationStatus {
    if ([super init]) {
        _authorizationStatus = authorizationStatus;
    }
    return self;
}

- (FREObject)toFREObject {
    FREObject resultObject;
    if (FRENewObject((const uint8_t *)"com.github.airext.notification.NotificationCenterSettings", 0, NULL, &resultObject, NULL) != FRE_OK) {
        return NULL;
    }
    if (FRESetObjectProperty(resultObject, (const uint8_t *)"authorizationStatus", [ANXDeviceInfoConversionRoutines convertNSStringToFREObject:_authorizationStatus], NULL) != FRE_OK) {
        return NULL;
    }
    return resultObject;
}

@end
