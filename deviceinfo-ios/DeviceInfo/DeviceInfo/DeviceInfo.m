//
//  DeviceInfo.m
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoreTelephony.h"

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

CTServerConnectionRef conn;
void ConnectionCallback(CTServerConnectionRef connection, CFStringRef string, CFDictionaryRef dictionary, void *data)
{
	NSLog(@"DeviceInfo.ConnectionCallback");
	CFShow(dictionary);
}

- (NSString*) getIMEI
{
    NSLog(@"DeviceInfo.getIMEI");
    
    NSString* result = nil;
    
    @try
    {
        struct CTResult it;
        
        CFMutableDictionaryRef dict;
        conn = _CTServerConnectionCreate(kCFAllocatorDefault, ConnectionCallback,NULL);
        
        _CTServerConnectionCopyMobileEquipmentInfo(&it, conn, &dict);
        
        NSLog (@ "dict is %@", dict);
        CFStringRef meid = CFDictionaryGetValue(dict, CFSTR("kCTMobileEquipmentInfoMEID"));
        NSLog (@ "meid is %@", meid);
        CFStringRef mobileId = CFDictionaryGetValue(dict, CFSTR("kCTMobileEquipmentInfoCurrentMobileId"));
        NSLog (@ "mobileId is %@", mobileId);
        
        result = CFBridgingRelease(mobileId);
    }
    @catch (NSException *exception)
    {
        NSLog(@"DeviceInfo.getIMEI: %@", exception);
    }
    @finally
    {
        // does nothing
    }
    
    return result;
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

@end