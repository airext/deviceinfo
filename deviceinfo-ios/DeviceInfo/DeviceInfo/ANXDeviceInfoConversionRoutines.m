//
//  FRETypeConversion.m
//  Contacts
//
//  Created by Maxim on 9/25/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FlashRuntimeExtensions.h"

#import "ANXDeviceInfoConversionRoutines.h"

@implementation ANXDeviceInfoConversionRoutines

#pragma mark Write object's properties

+(void) setStringTo: (FREObject) object withValue: (NSString *) value forProperty: (NSString *) property
{
    FREObject temp = [self convertNSStringToFREObject: value];
    
    if (temp == NULL)
    {
        return;
    }
    
    FRESetObjectProperty(object, (const uint8_t*) [property UTF8String], temp, NULL);
}

#pragma mark Conversion methods

+(FREObject) convertNSStringToFREObject:(NSString*) string
{
    if (string == nil) return NULL;
    
    const char* utf8String = string.UTF8String;
    
    unsigned long length = strlen( utf8String );
    
    FREObject converted;
    FREResult result = FRENewObjectFromUTF8((uint32_t) length + 1, (const uint8_t*) utf8String, &converted);
    
    if (result != FRE_OK)
        return NULL;
    
    return converted;
}

+(NSString*) convertFREObjectToNSString: (FREObject) string
{
    FREResult result;
    
    uint32_t length = 0;
    const uint8_t* tempValue = NULL;
    
    result = FREGetObjectAsUTF8(string, &length, &tempValue);
    
    if (result != FRE_OK)
        return nil;
    
    return [NSString stringWithUTF8String: (char*) tempValue];
}


+(NSDate*) convertFREObjectToNSDate: (FREObject) date
{
    FREResult result;
    
    FREObject time;
    result = FREGetObjectProperty(date, (const uint8_t*) "time", &time, NULL);
    
    if (result != FRE_OK)
        return nil;
    
    NSTimeInterval interval;
    
    result = FREGetObjectAsDouble(time, &interval);
    
    if (result != FRE_OK)
        return nil;
    
    interval = interval / 1000;
    
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

+(NSUInteger) convertFREObjectToNSUInteger: (FREObject) integer withDefault: (NSUInteger) defaultValue;
{
    FREResult result;
    
    uint32_t tempValue;
    
    result = FREGetObjectAsUint32(integer, &tempValue);
    
    if (result != FRE_OK)
        return defaultValue;
    
    return (NSUInteger) tempValue;
}

+(NSInteger) convertFREObjectToNSInteger: (FREObject) integer withDefault: (NSInteger) defaultValue {
    FREResult result;
    
    int32_t tempValue;
    result = FREGetObjectAsInt32(integer, &tempValue);
    
    if (result != FRE_OK)
        return defaultValue;
    
    return (NSUInteger) tempValue;
}
+(FREObject) convertNSIntegerToFREObject: (NSInteger) integer {
    FREObject result;
    if (FRENewObjectFromInt32((int32_t)integer, &result) == FRE_OK) {
        return result;
    } else {
        return NULL;
    }
}

+(FREObject) convertLongLongToFREObject: (long long) number
{
    FREObject result;
    FRENewObjectFromUint32((uint32_t) number, &result);
    
    return result;
}

+(double) convertFREObjectToDouble: (FREObject) number
{
    FREResult result;
    
    double value;
    
    result = FREGetObjectAsDouble(number, &value);
    
    if (result != FRE_OK)
        return 0.0;
    
    return value;
}

+(FREObject) convertBoolToFREObject: (BOOL) value
{
    FREObject result = NULL;
    
    if (value)
        FRENewObjectFromBool((uint32_t) 1, &result);
    else
        FRENewObjectFromBool((uint32_t) 0, &result);
    
    return result;
}

+(BOOL) convertFREObjectToBool: (FREObject) value
{
    uint32_t tempValue;
    
    FREResult result = FREGetObjectAsBool(value, &tempValue);
    
    if (result != FRE_OK)
        return NO;
    
    return tempValue > 0;
}

+ (NSString*)readNSStringFrom:(FREObject)object field:(NSString*)field withDefaultValue:(NSString*)defaultValue {
    FREObject propertyObject;
    if (FREGetObjectProperty(object, (const uint8_t *)[field UTF8String], &propertyObject, NULL) == FRE_OK) {
        return [self convertFREObjectToNSString:propertyObject] ?: defaultValue;
    } else {
        return defaultValue;
    }
}

+ (NSInteger)readNSIntegerFrom:(FREObject)object field:(NSString*)field withDefaultValue:(NSInteger)defaultValue {
    FREObject propertyObject;
    if (FREGetObjectProperty(object, (const uint8_t *)[field UTF8String], &propertyObject, NULL) == FRE_OK) {
        return [self convertFREObjectToNSInteger:propertyObject withDefault:defaultValue];
    } else {
        return defaultValue;
    }
}

+ (double)readDoubleFrom:(FREObject)object field:(NSString*)field withDefaultValue:(double)defaultValue {
    
    FREObject propertyObject = [self readFREObjectFrom:object field:field];
    if (propertyObject != NULL) {
        return [self convertFREObjectToDouble:propertyObject];
    } else {
        return defaultValue;
    }
}

+ (FREObject)readFREObjectFrom:(FREObject)object field:(NSString*)field {
    FREObject propertyObject;
    if (FREGetObjectProperty(object, (const uint8_t *)[field UTF8String], &propertyObject, NULL) == FRE_OK) {
        return propertyObject;
    } else {
        return NULL;
    }
}

@end
