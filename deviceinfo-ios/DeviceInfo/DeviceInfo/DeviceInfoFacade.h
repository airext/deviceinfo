//
//  DeviceInfoFacade.h
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import "FlashRuntimeExtensions.h"

#import "FRETypeConversion.h"

#import "DeviceInfo.h"

#pragma mark API

FREObject getIMEI(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

#pragma mark ContextInitialize/ContextFinalizer

void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

void ContextFinalizer(FREContext ctx);

#pragma mark Initializer/Finalizer

void Initializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);

void Finalizer(void* extData);
