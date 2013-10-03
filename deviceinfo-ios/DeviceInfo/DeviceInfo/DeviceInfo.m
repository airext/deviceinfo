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

+(DeviceInfo*) sharedInstance
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
	NSLog(@"ConnectionCallback");
	CFShow(dictionary);
}

-(NSString*) getIMEI
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
    
    return CFBridgingRelease(mobileId);
}

@end