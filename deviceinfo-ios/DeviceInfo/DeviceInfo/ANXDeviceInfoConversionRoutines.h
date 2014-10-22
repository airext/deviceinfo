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

+ (FREResult) convertFREStringToNSString:(FREObject) string asString:(NSString**) toString;
+ (FREResult) convertNSStringToFREString:(NSString*) string asString:(FREObject*) toString;

+ (FREResult) convertFREDateToNSDate:(FREObject) date asDate:(NSDate**) toDate;
+ (FREResult) convertNSDateToFREDate:(NSDate*) date asDate:(FREObject*) toDate;

+ (FREResult) convertNSDictionaryToFREObject:(NSDictionary*) dictionary asObject:(FREObject*) toObject;

@end
