//
//  DeviceInfo.m
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import "DeviceInfo.h"

@implementation DeviceInfo

#pragma mark Shared Instance

static DeviceInfo* _sharedInstance = nil;

+ (DeviceInfo*) sharedInstance
{
    if (_sharedInstance == nil)
    {
        _sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return _sharedInstance;
}

- (NSString*) getIMEI 
{
    NSLog(@"DeviceInfo.getIMEI");
    
    return nil;
}

- (NSDictionary*) getDeviceInfo
{
    NSLog(@"DeviceInfo.getDeviceInfo");
    
    NSMutableDictionary* result;
    
    @try
    {
        result = [NSMutableDictionary dictionary];
        
        UIDevice* device = [UIDevice currentDevice];
        
        [result setObject:device.name forKey:@"name"];
        [result setObject:device.model forKey:@"model"];
        [result setObject:device.systemName forKey:@"systemName"];
        [result setObject:device.systemVersion forKey:@"systemVersion"];
        
        [result setObject:@"Apple" forKey:@"manufacturer"];
    }
    @catch (NSException *exception)
    {
        NSLog(@"DeviceInfo.getDeviceInfo: %@", exception);
    }
    @finally
    {
        // does nothing
    }
    
    return result;
}

- (NSString*) getDeviceIdentifier
{
    NSUUID* id = [[UIDevice currentDevice] identifierForVendor];
    
    if (id != nil)
        return [id UUIDString];
    else
        return nil;
}

@end