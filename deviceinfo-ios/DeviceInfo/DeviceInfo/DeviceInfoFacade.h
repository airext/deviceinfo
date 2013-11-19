//
//  DeviceInfoFacade.h
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import "FlashRuntimeExtensions.h"

#import "DeviceInfo_FRETypeConversion.h"

#import "DeviceInfo.h"

#pragma mark API

FREObject DeviceInfo_isSupported(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject DeviceInfo_getIMEI(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject DeviceInfo_getPlatform(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject DeviceInfo_getDeviceInfo(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject DeviceInfo_getDeviceIdentifier(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

#pragma mark ContextInitialize/ContextFinalizer

void DeviceInfoContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

void DeviceInfoContextFinalizer(FREContext ctx);

#pragma mark Initializer/Finalizer

void DeviceInfoInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);

void DeviceInfoFinalizer(void* extData);
