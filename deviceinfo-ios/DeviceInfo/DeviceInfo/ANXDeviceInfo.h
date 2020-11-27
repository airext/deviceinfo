//
//  DeviceInfo.h
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FlashRuntimeExtensions.h"
#import "ANXDeviceInfoGeneral.h"
#import "ANXDeviceInfoConversionRoutines.h"

@interface ANXDeviceInfo : NSObject

#pragma mark Shared Instance

+ (ANXDeviceInfo*) sharedInstance;

#pragma mark Properties

@property FREContext context;

#pragma mark API Funcitons

-(BOOL) isSupported;

-(ANXDeviceInfoGeneral*) getGeneralInfo;

-(NSString *) getIMEI;

-(NSString *) getVendorIdentifier;

#pragma mark Dispatch events

-(void) dispatch: (NSString *) code withLevel: (NSString *) level;

-(void) dispatchError: (NSString *)code;

-(void) dispatchStatus: (NSString *)code;

@end
