//
//  FRETypeConversion.h
//  Contacts
//
//  Created by Maxim on 9/25/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FlashRuntimeExtensions.h"

@interface ANXDeviceInfoConversionRoutines : NSObject

#pragma mark Write object's properties

+(void) setStringTo: (FREObject) object withValue: (NSString *) value forProperty: (NSString *) property;

#pragma mark Conversion methods

+(FREObject) convertNSStringToFREObject:(NSString*) string;
+(NSString*) convertFREObjectToNSString: (FREObject) string;

+(NSDate*) convertFREObjectToNSDate: (FREObject) date;

+(NSUInteger) convertFREObjectToNSUInteger: (FREObject) integer withDefault: (NSUInteger) defaultValue;

+(FREObject) convertLongLongToFREObject: (long long) number;

+(double) convertFREObjectToDouble: (FREObject) number;

+(BOOL) convertFREObjectToBool: (FREObject) value;
+(FREObject) convertBoolToFREObject: (BOOL) value;

@end
