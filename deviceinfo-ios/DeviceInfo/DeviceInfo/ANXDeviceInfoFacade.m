//
//  DeviceInfoFacade2.m
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import "ANXDeviceInfoFacade.h"

#pragma mark General API

FREObject ANXDeviceInfoIsSupported(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    FRENewObjectFromBool([[ANXDeviceInfo sharedInstance] isSupported], &result);
    
    return result;
}

FREObject ANXDeviceInfoGetIMEI(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    return [ANXDeviceInfoConversionRoutines convertNSStringToFREObject:[[ANXDeviceInfo sharedInstance] getIMEI]];
}

FREObject ANXDeviceInfoGetGeneralInfo(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    ANXDeviceInfoGeneral *general = [[ANXDeviceInfo sharedInstance] getGeneralInfo];
    
    return [general toFREOject];
}

#pragma mark Battery API

FREObject ANXDeviceInfoGetBatteryLevel(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    return [ANXDeviceInfoConversionRoutines convertLongLongToFREObject:(long long)[ANXDeviceInfoBattery getBatteryLevel]];
}

FREObject ANXDeviceInfoGetBatteryState(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    return [ANXDeviceInfoConversionRoutines convertNSStringToFREObject:[ANXDeviceInfoBattery getBatteryState]];
}

FREObject ANXDeviceInfoStartBatteryMonitoring(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    [ANXDeviceInfoBattery startMonitoring];
    
    return NULL;
}

FREObject ANXDeviceInfoStopBatteryMonitoring(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    [ANXDeviceInfoBattery stopMonitoring];
    
    return NULL;
}

#pragma mark iOS specific API

FREObject ANXDeviceInfoGetVendorIdentifier(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    return [ANXDeviceInfoConversionRoutines convertNSStringToFREObject:[[ANXDeviceInfo sharedInstance] getVendorIdentifier]];
}

#pragma mark ContextInitialize/ContextFinalizer

void ANXDeviceInfoContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    *numFunctionsToTest = 8;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    
    // general
    
    func[0].name = (const uint8_t*) "isSupported";
    func[0].functionData = NULL;
    func[0].function = &ANXDeviceInfoIsSupported;
    
    func[1].name = (const uint8_t*) "getIMEI";
    func[1].functionData = NULL;
    func[1].function = &ANXDeviceInfoGetIMEI;
    
    func[2].name = (const uint8_t*) "getGeneralInfo";
    func[2].functionData = NULL;
    func[2].function = &ANXDeviceInfoGetGeneralInfo;
    
    // battery
    
    func[3].name = (const uint8_t*) "getBatteryLevel";
    func[3].functionData = NULL;
    func[3].function = &ANXDeviceInfoGetBatteryLevel;
    
    func[4].name = (const uint8_t*) "getBatteryState";
    func[4].functionData = NULL;
    func[4].function = &ANXDeviceInfoGetBatteryState;
    
    
    func[5].name = (const uint8_t*) "startBatteryMonitoring";
    func[5].functionData = NULL;
    func[5].function = &ANXDeviceInfoStartBatteryMonitoring;
    
    func[6].name = (const uint8_t*) "stopBatteryMonitoring";
    func[6].functionData = NULL;
    func[6].function = &ANXDeviceInfoStopBatteryMonitoring;
    
    // ios
    
    func[7].name = (const uint8_t*) "iosGetVendorIdentifier";
    func[7].functionData = NULL;
    func[7].function = &ANXDeviceInfoGetVendorIdentifier;
    
    *functionsToSet = func;
    
    [ANXDeviceInfo sharedInstance].context = ctx;
}

void ANXDeviceInfoContextFinalizer(FREContext ctx)
{
    [ANXDeviceInfo sharedInstance].context = nil;
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
