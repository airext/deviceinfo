//
//  DeviceInfoFacade.h
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import "FlashRuntimeExtensions.h"

#import "ANXDeviceInfoConversionRoutines.h"

#import "ANXDeviceInfo.h"

#import "ANXDeviceInfoBattery.h"

#pragma mark API

FREObject ANXDeviceInfoIsSupported(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject ANXDeviceInfoGetIMEI(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject ANXDeviceInfoGetPlatform(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject ANXDeviceInfoGetDeviceInfo(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject ANXDeviceInfoGetVendorIdentifier(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

#pragma mark ContextInitialize/ContextFinalizer

void ANXDeviceInfoContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

void ANXDeviceInfoContextFinalizer(FREContext ctx);

#pragma mark Initializer/Finalizer

void ANXDeviceInfoInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);

void ANXDeviceInfoFinalizer(void* extData);
