//
//  DeviceInfoFacade2.m
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import "DeviceInfoFacade.h"

#pragma mark API

FREObject isSupported(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    FRENewObjectFromBool(YES, &result);
    
    return result;
}

FREObject getIMEI(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    [FRETypeConversion convertNSStringToFREString:[[DeviceInfo sharedInstance] getIMEI] asString:&result];
    
    return result;
}

#pragma mark ContextInitialize/ContextFinalizer

void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    *numFunctionsToTest = 2;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    
    func[0].name = (const uint8_t*) "isSupported";
    func[0].functionData = NULL;
    func[0].function = &isSupported;
    
    func[1].name = (const uint8_t*) "getIMEI";
    func[1].functionData = NULL;
    func[1].function = &getIMEI;
    
    *functionsToSet = func;
}

void ContextFinalizer(FREContext ctx)
{
    
}

#pragma mark Initializer/Finalizer

void Initializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    
    *ctxInitializerToSet = &ContextInitializer;
	*ctxFinalizerToSet = &ContextFinalizer;
}

void Finalizer(void* extData)
{
    
}
