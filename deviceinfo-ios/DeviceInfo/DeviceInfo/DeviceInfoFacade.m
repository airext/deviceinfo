//
//  DeviceInfoFacade2.m
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import "DeviceInfoFacade.h"

#pragma mark API

FREObject DeviceInfo_isSupported(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    FRENewObjectFromBool(TRUE, &result);
    
    return result;
}

FREObject DeviceInfo_getIMEI(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    [DeviceInfo_FRETypeConversion convertNSStringToFREString:[[DeviceInfo sharedInstance] getIMEI] asString:&result];
    
    return result;
}

FREObject DeviceInfo_getPlatform(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    FRENewObjectFromUTF8(4, (const uint8_t*) "ios", &result);
    
    return result;
}

FREObject DeviceInfo_getDeviceInfo(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    NSLog(@"getDeviceInfo");
    
    NSDictionary* info = [[DeviceInfo sharedInstance] getDeviceInfo];
    
    FRENewObject((const uint8_t*) "Object", 0, NULL, &result, NULL);
    
    FREObject name;
    [DeviceInfo_FRETypeConversion convertNSStringToFREString:[info objectForKey:@"name"] asString:&name];
    FRESetObjectProperty(result, (const uint8_t*) "name", name, NULL);
    
    FREObject model;
    [DeviceInfo_FRETypeConversion convertNSStringToFREString:[info objectForKey:@"model"] asString:&model];
    FRESetObjectProperty(result, (const uint8_t*) "model", model, NULL);
    
    FREObject manufacturer;
    [DeviceInfo_FRETypeConversion convertNSStringToFREString:[info objectForKey:@"manufacturer"] asString:&manufacturer];
    FRESetObjectProperty(result, (const uint8_t*) "manufacturer", manufacturer, NULL);
    
    FREObject systemName;
    [DeviceInfo_FRETypeConversion convertNSStringToFREString:[info objectForKey:@"systemName"] asString:&systemName];
    FRESetObjectProperty(result, (const uint8_t*) "systemName", systemName, NULL);
    
    FREObject systemVersion;
    [DeviceInfo_FRETypeConversion convertNSStringToFREString:[info objectForKey:@"systemVersion"] asString:&systemVersion];
    FRESetObjectProperty(result, (const uint8_t*) "systemVersion", systemVersion, NULL);
    
//    [FRETypeConversion convertNSDictionaryToFREObject:[[DeviceInfo sharedInstance] getDeviceInfo] asObject:&result];
    
    return result;
}

FREObject DeviceInfo_getDeviceIdentifier(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    [DeviceInfo_FRETypeConversion convertNSStringToFREString:[[DeviceInfo sharedInstance] getDeviceIdentifier] asString:&result];
    
    return result;
}

#pragma mark ContextInitialize/ContextFinalizer

void DeviceInfoContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    *numFunctionsToTest = 5;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    
    func[0].name = (const uint8_t*) "isSupported";
    func[0].functionData = NULL;
    func[0].function = &DeviceInfo_isSupported;
    
    func[1].name = (const uint8_t*) "getIMEI";
    func[1].functionData = NULL;
    func[1].function = &DeviceInfo_getIMEI;
    
    func[2].name = (const uint8_t*) "getDeviceInfo";
    func[2].functionData = NULL;
    func[2].function = &DeviceInfo_getDeviceInfo;
    
    func[3].name = (const uint8_t*) "getPlatform";
    func[3].functionData = NULL;
    func[3].function = &DeviceInfo_getPlatform;
    
    func[4].name = (const uint8_t*) "getDeviceIdentifier";
    func[4].functionData = NULL;
    func[4].function = &DeviceInfo_getDeviceIdentifier;
    
    *functionsToSet = func;
}

void DeviceInfoContextFinalizer(FREContext ctx)
{
    
}

#pragma mark Initializer/Finalizer

void DeviceInfoInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    
    *ctxInitializerToSet = &DeviceInfoContextInitializer;
	*ctxFinalizerToSet = &DeviceInfoContextFinalizer;
}

void DeviceInfoFinalizer(void* extData)
{
    
}
