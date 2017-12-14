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

+(NSInteger) convertFREObjectToNSInteger: (FREObject) integer withDefault: (NSInteger) defaultValue;
+(FREObject) convertNSIntegerToFREObject: (NSInteger) integer;

+(FREObject) convertLongLongToFREObject: (long long) number;

+(double) convertFREObjectToDouble: (FREObject) number;

+(BOOL) convertFREObjectToBool: (FREObject) value;
+(FREObject) convertBoolToFREObject: (BOOL) value;

+ (NSString*)readNSStringFrom:(FREObject)object field:(NSString*)field withDefaultValue:(NSString*)defaultValue;
+ (NSInteger)readNSIntegerFrom:(FREObject)object field:(NSString*)field withDefaultValue:(NSInteger)defaultValue;
+ (double)readDoubleFrom:(FREObject)object field:(NSString*)field withDefaultValue:(double)defaultValue;

+ (FREObject)readFREObjectFrom:(FREObject)object field:(NSString*)field;

@end
