//
//  DeviceInfoFacade2.m
//  DeviceInfo
//
//  Created by Maxim on 10/3/13.
//  Copyright (c) 2013 Max Rozdobudko. All rights reserved.
//

#import "ANXDeviceInfoFacade.h"
#import "ANXBridge.h"
#import "ANXDeviceInfoAlert.h"
#import "ANXBridgeSupport.h"
#import "ANXDeviceInfoScreen.h"
#import <AudioToolbox/AudioServices.h>

#pragma mark General API

FREObject ANXDeviceInfoIsSupported(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoIsSupported");
    return [ANXDeviceInfoConversionRoutines convertBoolToFREObject:ANXDeviceInfo.sharedInstance.isSupported];
}

FREObject ANXDeviceInfoGetIMEI(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoGetIMEI");
    return [ANXDeviceInfoConversionRoutines convertNSStringToFREObject:[[ANXDeviceInfo sharedInstance] getIMEI]];
}

FREObject ANXDeviceInfoGetGeneralInfo(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoGetGeneralInfo");
    ANXDeviceInfoGeneral *general = [[ANXDeviceInfo sharedInstance] getGeneralInfo];
    return [general toFREOject];
}

#pragma mark Battery API

FREObject ANXDeviceInfoGetBatteryLevel(FREContext context, void* functionData, uint32_t argc, FREObject argv[]){
    NSLog(@"ANXDeviceInfoGetBatteryLevel");
    return [ANXDeviceInfoConversionRoutines convertLongLongToFREObject:(long long)[ANXDeviceInfoBattery getBatteryLevel]];
}

FREObject ANXDeviceInfoGetBatteryState(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoGetBatteryState");
    return [ANXDeviceInfoConversionRoutines convertNSStringToFREObject:[ANXDeviceInfoBattery getBatteryState]];
}

FREObject ANXDeviceInfoStartBatteryMonitoring(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoStartBatteryMonitoring");
    [ANXDeviceInfoBattery startMonitoring];
    return NULL;
}

FREObject ANXDeviceInfoStopBatteryMonitoring(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoStopBatteryMonitoring");
    [ANXDeviceInfoBattery stopMonitoring];
    return NULL;
}


FREObject ANXDeviceInfoLog(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoLog");

    if (argc == 2)
    {
        NSLog(@"%@", [ANXDeviceInfoConversionRoutines convertFREObjectToNSString:argv[1]]);
    }
    
    return NULL;
}

FREObject ANXDeviceInfoCrash(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoCrash");

    // causes out of range exception
    
    @[][1];

    return NULL;
}

#pragma mark StatusBar API

FREObject ANXDeviceInfoSetStatusBarStyle(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoSetStatusBarStyle");

    if (argc == 1) {
        NSString* style = [ANXDeviceInfoConversionRoutines convertFREObjectToNSString:argv[0]];
        
        [ANXDeviceInfoStatusBar setStyle:style];
    }
    
    return NULL;
}

FREObject ANXDeviceInfoGetStatusBarStyle(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoGetStatusBarStyle");
    return [ANXDeviceInfoConversionRoutines convertNSStringToFREObject:[ANXDeviceInfoStatusBar getStyle]];
}

#pragma mark iOS specific API

FREObject ANXDeviceInfoGetVendorIdentifier(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoGetVendorIdentifier");
    return [ANXDeviceInfoConversionRoutines convertNSStringToFREObject:[[ANXDeviceInfo sharedInstance] getVendorIdentifier]];
}

#pragma mark Alert

FREObject ANXDeviceInfoPresentAlert(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoPresentAlert");

    ANXBridgeCall* call = [ANXBridge call:context];
    
    NSString* title              = [ANXDeviceInfoConversionRoutines convertFREObjectToNSString:argv[0]];
    NSString* message            = [ANXDeviceInfoConversionRoutines convertFREObjectToNSString:argv[1]];
    
    FREObject alertStyleRawValue;
    FREGetObjectProperty(argv[2], (const uint8_t *)"rawValue", &alertStyleRawValue, NULL);
    
    UIAlertControllerStyle style = [ANXDeviceInfoConversionRoutines convertFREObjectToNSUInteger:alertStyleRawValue withDefault:UIAlertControllerStyleAlert];
    
    NSMutableArray* actionDescriptors = [NSMutableArray array];
    if (argc > 3) {
        FREObject actions = argv[3];
        uint32_t actionCount;
        FREGetArrayLength(actions, &actionCount);
        for (NSUInteger i = 0; i < actionCount; i++) {
            FREObject action;
            FREGetArrayElementAt(actions, (uint32_t) i, &action);
            FREObject actionTitle;
            FREGetObjectProperty(action, (const uint8_t *)"title", &actionTitle, NULL);
            FREObject actionStyle;
            FREGetObjectProperty(action, (const uint8_t *)"style", &actionStyle, NULL);
            FREObject actionStyleRawValue;
            FREGetObjectProperty(actionStyle, (const uint8_t *)"rawValue", &actionStyleRawValue, NULL);
            FREObject actionEnabled;
            FREGetObjectProperty(action, (const uint8_t *)"isEnabled", &actionEnabled, NULL);
            NSString* title = [ANXDeviceInfoConversionRoutines convertFREObjectToNSString:actionTitle];
            NSNumber* style = [NSNumber numberWithUnsignedInteger:[ANXDeviceInfoConversionRoutines convertFREObjectToNSUInteger:actionStyleRawValue withDefault:0]];
            NSNumber* enabled = [NSNumber numberWithBool: [ANXDeviceInfoConversionRoutines convertFREObjectToBool:actionEnabled]];
            NSNumber* index = [NSNumber numberWithUnsignedInteger:i];
            
            NSMutableDictionary* actionDescriptor = [NSMutableDictionary dictionary];
            [actionDescriptor setObject:title forKey:@"title"];
            [actionDescriptor setObject:style forKey:@"style"];
            [actionDescriptor setObject:enabled forKey:@"enabled"];
            [actionDescriptor setObject:index forKey:@"index"];
            [actionDescriptors addObject:actionDescriptor];
        }
    }
    
    [ANXDeviceInfoAlert presentAlertWithTitle:title message:message preferredStyle:style withActions:actionDescriptors animated:YES withCompletion:^(NSInteger actionIndex) {
        [call result:[ANXDeviceInfoVO valueObjectWithInteger:actionIndex]];
    }];
    
    return [call toFREObject];
}

FREObject ANXDeviceInfoDismissAlert(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoDismissAlert");

    [ANXDeviceInfoAlert dismissAlertAnimated:YES];
    
    if (argc > 0) {
        NSInteger callId = [ANXDeviceInfoConversionRoutines convertFREObjectToNSUInteger:argv[0] withDefault:ANX_BRIDGE_MAX_QUEUE_LENGTH];
        if (callId != ANX_BRIDGE_MAX_QUEUE_LENGTH) {
            ANXBridgeCall* call = [ANXBridge callWithId:callId];
            [call cancel];
        }
    }
    
    return NULL;
}

#pragma mark Theme

FREObject ANXDeviceInfoThemeIsSupported(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoThemeIsSupported");
    return [ANXDeviceInfoConversionRoutines convertBoolToFREObject:NO];
}

FREObject ANXDeviceInfoThemeSetStyle(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoThemeSetStyle");
    return NULL;
}

#pragma mark Vibration

FREObject ANXDeviceInfoVibrate(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoVibrate");
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    return NULL;
}

#pragma mark Screen

FREObject ANXDeviceInfoGetSafeArea(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoGetSafeArea");

    UIEdgeInsets safeArea = [ANXDeviceInfoScreen getSafeArea];

    FREObject top = [ANXDeviceInfoConversionRoutines convertDoubleToFREObject:(CGFloat)safeArea.top];
    FREObject left = [ANXDeviceInfoConversionRoutines convertDoubleToFREObject:(CGFloat)safeArea.left];
    FREObject bottom = [ANXDeviceInfoConversionRoutines convertDoubleToFREObject:(CGFloat)safeArea.bottom];
    FREObject right = [ANXDeviceInfoConversionRoutines convertDoubleToFREObject:(CGFloat)safeArea.right];

    FREObject args[] = { top, left, bottom, right };

    FREObject insets;
    if (FRENewObject((const uint8_t *) "com.github.airext.deviceinfo.data.EdgeInsets", 4, args, &insets, NULL) != FRE_OK) {
        return NULL;
    }
    
    return insets;
}

#pragma mark Settings

FREObject ANXDeviceInfoOpenSettings(FREContext context, void* functionData, uint32_t argc, FREObject argv[]) {
    NSLog(@"ANXDeviceInfoOpenSettings");
    NSURL* appSettingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if (appSettingsURL != nil) {
        [UIApplication.sharedApplication openURL:appSettingsURL];
    }
    return NULL;
}

#pragma mark ContextInitialize/ContextFinalizer

void ANXDeviceInfoContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet)
{
    NSLog(@"ANXDeviceInfoContextInitializer");
    
    *numFunctionsToSet = 19;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToSet));
    
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

    // special
    
    func[7].name = (const uint8_t*) "log";
    func[7].functionData = NULL;
    func[7].function = &ANXDeviceInfoLog;
    
    func[8].name = (const uint8_t*) "crash";
    func[8].functionData = NULL;
    func[8].function = &ANXDeviceInfoCrash;
    
    // ios
    
    func[9].name = (const uint8_t*) "iosGetVendorIdentifier";
    func[9].functionData = NULL;
    func[9].function = &ANXDeviceInfoGetVendorIdentifier;
    
    // status bar
    
    func[10].name = (const uint8_t*) "getStatusBarStyle";
    func[10].functionData = NULL;
    func[10].function = &ANXDeviceInfoGetStatusBarStyle;
    
    func[11].name = (const uint8_t*) "setStatusBarStyle";
    func[11].functionData = NULL;
    func[11].function = &ANXDeviceInfoSetStatusBarStyle;
    
    // alert
    
    func[12].name = (const uint8_t*) "presentAlert";
    func[12].functionData = NULL;
    func[12].function = &ANXDeviceInfoPresentAlert;

    func[13].name = (const uint8_t*) "dismissAlert";
    func[13].functionData = NULL;
    func[13].function = &ANXDeviceInfoDismissAlert;
    
    // themes
    
    func[14].name = (const uint8_t*) "themeIsSupported";
    func[14].functionData = NULL;
    func[14].function = &ANXDeviceInfoThemeIsSupported;
    
    func[15].name = (const uint8_t*) "themeSetStyle";
    func[15].functionData = NULL;
    func[15].function = &ANXDeviceInfoThemeSetStyle;
    
    // vibration
    
    func[16].name = (const uint8_t*) "vibrate";
    func[16].functionData = NULL;
    func[16].function = &ANXDeviceInfoVibrate;

    // screen

    func[17].name = (const uint8_t*) "getSafeArea";
    func[17].functionData = NULL;
    func[17].function = &ANXDeviceInfoGetSafeArea;

    // settings

    func[18].name = (const uint8_t*) "openSettings";
    func[18].functionData = NULL;
    func[18].function = &ANXDeviceInfoOpenSettings;

    // setup bridge
    
    [ANXBridge setup:numFunctionsToSet functions:&func];

    *functionsToSet = func;
    
    [ANXDeviceInfo sharedInstance].context = ctx;
}

void ANXDeviceInfoContextFinalizer(FREContext ctx)
{
    NSLog(@"ANXDeviceInfoContextFinalizer");
    
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
