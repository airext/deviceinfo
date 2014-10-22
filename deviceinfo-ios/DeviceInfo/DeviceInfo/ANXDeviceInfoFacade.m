//
//  DeviceInfoFacade2.m
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import "ANXDeviceInfoFacade.h"

#pragma mark API

FREObject ANXDeviceInfoIsSupported(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    FRENewObjectFromBool(TRUE, &result);
    
    return result;
}

FREObject ANXDeviceInfoGetIMEI(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    [ANXDeviceInfoConversionRoutines convertNSStringToFREString:[[ANXDeviceInfo sharedInstance] getIMEI] asString:&result];
    
    return result;
}

FREObject ANXDeviceInfoGetPlatform(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    FRENewObjectFromUTF8(4, (const uint8_t*) "ios", &result);
    
    return result;
}

FREObject ANXDeviceInfoGetDeviceInfo(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    NSDictionary* info = [[ANXDeviceInfo sharedInstance] getDeviceInfo];
    
    FRENewObject((const uint8_t*) "Object", 0, NULL, &result, NULL);
    
    FREObject name;
    [ANXDeviceInfoConversionRoutines convertNSStringToFREString:[info objectForKey:@"name"] asString:&name];
    FRESetObjectProperty(result, (const uint8_t*) "name", name, NULL);
    
    FREObject model;
    [ANXDeviceInfoConversionRoutines convertNSStringToFREString:[info objectForKey:@"model"] asString:&model];
    FRESetObjectProperty(result, (const uint8_t*) "model", model, NULL);
    
    FREObject manufacturer;
    [ANXDeviceInfoConversionRoutines convertNSStringToFREString:[info objectForKey:@"manufacturer"] asString:&manufacturer];
    FRESetObjectProperty(result, (const uint8_t*) "manufacturer", manufacturer, NULL);
    
    FREObject systemName;
    [ANXDeviceInfoConversionRoutines convertNSStringToFREString:[info objectForKey:@"systemName"] asString:&systemName];
    FRESetObjectProperty(result, (const uint8_t*) "systemName", systemName, NULL);
    
    FREObject systemVersion;
    [ANXDeviceInfoConversionRoutines convertNSStringToFREString:[info objectForKey:@"systemVersion"] asString:&systemVersion];
    FRESetObjectProperty(result, (const uint8_t*) "systemVersion", systemVersion, NULL);
    
//    [FRETypeConversion convertNSDictionaryToFREObject:[[DeviceInfo sharedInstance] getDeviceInfo] asObject:&result];
    
    return result;
}

FREObject ANXDeviceInfoGetDeviceIdentifier(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    [ANXDeviceInfoConversionRoutines convertNSStringToFREString:[[ANXDeviceInfo sharedInstance] getDeviceIdentifier] asString:&result];
    
    return result;
}

#pragma mark ContextInitialize/ContextFinalizer

void ANXDeviceInfoContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    *numFunctionsToTest = 5;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    
    func[0].name = (const uint8_t*) "isSupported";
    func[0].functionData = NULL;
    func[0].function = &ANXDeviceInfoIsSupported;
    
    func[1].name = (const uint8_t*) "getIMEI";
    func[1].functionData = NULL;
    func[1].function = &ANXDeviceInfoGetIMEI;
    
    func[2].name = (const uint8_t*) "getDeviceInfo";
    func[2].functionData = NULL;
    func[2].function = &ANXDeviceInfoGetDeviceInfo;
    
    func[3].name = (const uint8_t*) "getPlatform";
    func[3].functionData = NULL;
    func[3].function = &ANXDeviceInfoGetPlatform;
    
    func[4].name = (const uint8_t*) "getDeviceIdentifier";
    func[4].functionData = NULL;
    func[4].function = &ANXDeviceInfoGetDeviceIdentifier;
    
    *functionsToSet = func;
}

void ANXDeviceInfoContextFinalizer(FREContext ctx)
{
    
}

#pragma mark Initializer/Finalizer

void ANXDeviceInfoInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    NSLog(@"ANXDeviceInfoInitializer");
    
    *extDataToSet = NULL;
    
    *ctxInitializerToSet = &ANXDeviceInfoContextInitializer;
	*ctxFinalizerToSet = &ANXDeviceInfoContextFinalizer;
}

void ANXDeviceInfoFinalizer(void* extData)
{
    NSLog(@"ANXDeviceInfoFinalizer");
}
