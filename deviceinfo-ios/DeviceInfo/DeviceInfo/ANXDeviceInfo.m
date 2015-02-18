//
//  DeviceInfo.m
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import <AdSupport/AdSupport.h>

#import "ANXDeviceInfo.h"

@implementation ANXDeviceInfo

#pragma mark Shared Instance

static ANXDeviceInfo* _sharedInstance = nil;

+ (ANXDeviceInfo*) sharedInstance
{
    if (_sharedInstance == nil)
    {
        _sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return _sharedInstance;
}

#pragma mark Properties

@synthesize context;

#pragma mark API Funcitons

-(BOOL) isSupported
{
    return YES;
}

-(ANXDeviceInfoGeneral *) getGeneralInfo
{
    return [[ANXDeviceInfoGeneral alloc] init];
}

- (NSString*) getIMEI 
{
    NSLog(@"[DeviceInfo] Warning: IMEI is not supported on iOS.");
    
    return nil;
}

-(NSString *) getVendorIdentifier
{
    NSUUID* id = [[UIDevice currentDevice] identifierForVendor];
    
    if (id != nil)
        return [id UUIDString];
    else
        return nil;
}

#pragma mark Dispatch events

-(void) dispatch: (NSString *) code withLevel: (NSString *) level
{
    FREDispatchStatusEventAsync(context, (const uint8_t*) [code UTF8String], (const uint8_t*) [level UTF8String]);
}

-(void) dispatchError: (NSString *)code
{
    [self dispatch:code withLevel:@"error"];
}

-(void) dispatchStatus: (NSString *)code
{
    [self dispatch:code withLevel:@"status"];
}

@end