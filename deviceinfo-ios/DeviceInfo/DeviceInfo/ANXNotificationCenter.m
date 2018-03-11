//
//  ANXNotificationCenter.m
//  DeviceInfo
//
//  Created by Max Rozdobudko on 12/7/17.
//  Copyright © 2017 Max Rozdobudko. All rights reserved.
//

#import "ANXNotificationCenter.h"
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import <objc/runtime.h>
#import "ANXDeviceInfo.h"

NSString* ANXNotificationCenterErrorDomain = @"ANXNotificationCenterErrorDomain";

@implementation ANXNotificationCenter

# pragma mark Shared instance

static ANXNotificationCenter* _sharedInstance = nil;

+ (ANXNotificationCenter*)sharedInstance {
    if (_sharedInstance == nil) {
        _sharedInstance = [[super allocWithZone:NULL] init];
    }
    return _sharedInstance;
}

# pragma mark Swizzling

static ANXNotificationCenterDelegate* _delegate = nil;

+ (void)load {
    NSLog(@"ANXNotificationCenter load");
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id appDelegate = [[UIApplication sharedApplication] delegate];
        
        Class originalAppDelegateClass = object_getClass(appDelegate);
        NSString* anxDelegateClassName = [NSString stringWithFormat:@"ANX%@", NSStringFromClass(originalAppDelegateClass)];
        Class swizzledAppDelegateClass = objc_allocateClassPair(originalAppDelegateClass, [anxDelegateClassName UTF8String], 0);
        
        SEL applicationDidFinishLaunchingSelector = @selector(applicationDidFinishLaunching:);
        Method originalApplicationDidFinishLaunchingMethod = class_getInstanceMethod(originalAppDelegateClass, applicationDidFinishLaunchingSelector);
//        Method swizzledApplicationDidFinishLaunchingMethod = class_getInstanceMethod(ANXNotificationCenter.class, applicationDidFinishLaunchingSelector);
        IMP swizzledApplicationDidFinishLaunchingMethodImpl = class_getMethodImplementation(ANXNotificationCenter.class, applicationDidFinishLaunchingSelector);

        class_addMethod(swizzledAppDelegateClass, applicationDidFinishLaunchingSelector, swizzledApplicationDidFinishLaunchingMethodImpl, method_getTypeEncoding(originalApplicationDidFinishLaunchingMethod));

        SEL applicationDidFinishLaunchingWithOptionsSelector = @selector(application:didFinishLaunchingWithOptions:);
        Method originalApplicationDidFinishLaunchingWithOptionsMethod = class_getInstanceMethod(originalAppDelegateClass, applicationDidFinishLaunchingWithOptionsSelector);
        //        Method swizzledApplicationDidFinishLaunchingMethod = class_getInstanceMethod(ANXNotificationCenter.class, applicationDidFinishLaunchingSelector);
        IMP applicationDidFinishLaunchingWithOptionsMethodImpl = class_getMethodImplementation(ANXNotificationCenter.class, applicationDidFinishLaunchingWithOptionsSelector);

        class_addMethod(swizzledAppDelegateClass, applicationDidFinishLaunchingWithOptionsSelector, applicationDidFinishLaunchingWithOptionsMethodImpl, method_getTypeEncoding(originalApplicationDidFinishLaunchingWithOptionsMethod));

        
    
        
        SEL applicationDidRegisterUserNotificationSettingsSelector = @selector(application:didRegisterUserNotificationSettings:);
        Method originalApplicationDidRegisterUserNotificationSettingsMethod = class_getInstanceMethod(originalAppDelegateClass, applicationDidRegisterUserNotificationSettingsSelector);
        //        Method swizzledApplicationDidFinishLaunchingMethod = class_getInstanceMethod(ANXNotificationCenter.class, applicationDidFinishLaunchingSelector);
        IMP applicationDidRegisterUserNotificationSettingsMethodImpl = class_getMethodImplementation(ANXNotificationCenter.class, applicationDidRegisterUserNotificationSettingsSelector);
        
        class_addMethod(swizzledAppDelegateClass, applicationDidRegisterUserNotificationSettingsSelector, applicationDidRegisterUserNotificationSettingsMethodImpl, method_getTypeEncoding(originalApplicationDidRegisterUserNotificationSettingsMethod));

        
        
        SEL applicationDidEnterBackgroundSelector = @selector(applicationDidEnterBackground:);
        Method originalApplicationDidEnterBackgroundMethod = class_getInstanceMethod(originalAppDelegateClass, applicationDidEnterBackgroundSelector);
        //        Method swizzledApplicationDidFinishLaunchingMethod = class_getInstanceMethod(ANXNotificationCenter.class, applicationDidFinishLaunchingSelector);
        IMP applicationDidEnterBackgroundMethodImpl = class_getMethodImplementation(ANXNotificationCenter.class, applicationDidEnterBackgroundSelector);
        
        class_addMethod(swizzledAppDelegateClass, applicationDidEnterBackgroundSelector, applicationDidEnterBackgroundMethodImpl, method_getTypeEncoding(originalApplicationDidEnterBackgroundMethod));
        
        
//        SEL didRegisterUserNotificationSettingsSelector = @selector(application:didRegisterUserNotificationSettings:);
//
//        Method originalMethod = class_getInstanceMethod(object_getClass(appDelegate), applicationDidFinishLaunchingSelector);
//        Method swizzledMethod = class_getInstanceMethod(ANXNotificationCenter.class, applicationDidFinishLaunchingSelector);
        
        objc_registerClassPair(swizzledAppDelegateClass);
        object_setClass(appDelegate, swizzledAppDelegateClass);
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
            _delegate = [[ANXNotificationCenterDelegate alloc] init];
            UNUserNotificationCenter.currentNotificationCenter.delegate = _delegate;
        }
    });
}

- (void)applicationDidEnterBackground:(UIApplication*)application {
    NSLog(@"ANXNotificationCenter applicationDidEnterBackground");
}

- (void)applicationDidFinishLaunching:(UIApplication*)application {
    NSLog(@"ANXNotificationCenter applicationDidFinishLaunching");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    NSLog(@"ANXNotificationCenter application:didFinishLaunchingWithOptions:");
    return YES;
}

- (void)application:(UIApplication*)application didRegisterUserNotificationSettings:(UIUserNotificationSettings*)notificationSettings {
    NSLog(@"ANXNotificationCenter application:didRegisterUserNotificationSettings:");
    if (_authorizationCompletionHandler) {
        if ((notificationSettings.types & UIUserNotificationTypeAlert) > 0) {
            _authorizationCompletionHandler(YES, nil);
        } else {
            _authorizationCompletionHandler(NO, nil);
        }
        _authorizationCompletionHandler = nil;
    }
}
void didRegisterUserNotificationSettings(id self, SEL _cmd, UIApplication* application, UIUserNotificationSettings* notificationSettings) {
    NSLog(@"ANXNotificationCenter didRegisterUserNotificationSettings");
}

# pragma mark Availability & Permissions

+ (BOOL)isSupported {
    return YES;
}

+ (BOOL)isEnabled {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        return YES;
    } else {
        UIUserNotificationSettings* settings = UIApplication.sharedApplication.currentUserNotificationSettings;
        return (settings.types & UIUserNotificationTypeAlert) > 0;
    }
}

+ (BOOL)canOpenSettings {
    return NO;
}

+ (void)openSettings {
    
}

+ (void)getNotificationSettingsWithCompletion:(GetNotificationSettingsCompletion)completion {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        [UNUserNotificationCenter.currentNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            NSString* authorizationStatus = @"unknown";
            if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                authorizationStatus = @"granted";
            } else if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                authorizationStatus = @"denied";
            }
            if (completion) {
                completion(authorizationStatus);
            }
        }];
    } else {
        //        NSNotificationCenter
    }
}

static RequestAuthorizationCompletion _authorizationCompletionHandler;

+ (void)requestAuthorizationWithOPtions:(NSInteger)options withCompletion:(RequestAuthorizationCompletion)completion {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        [UNUserNotificationCenter.currentNotificationCenter requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:completion];
    } else {
        _authorizationCompletionHandler = completion;
        [UIApplication.sharedApplication registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil]];
    }
}

# pragma mark Background / Foreground

static BOOL _isInForeground;

+ (BOOL)isInForeground {
    return _isInForeground;
}
+ (void)inForeground {
    _isInForeground = YES;
    if (ANXNotificationCenter.sharedInstance.params) {
        [ANXDeviceInfo.sharedInstance dispatch:@"DeviceInfo.NotificationCenter.Notification.ReceivedInBackground" withLevel:ANXNotificationCenter.sharedInstance.params];
        ANXNotificationCenter.sharedInstance.params = nil;
    }
}
+ (void)inBackground {
    _isInForeground = NO;
}

# pragma mark Properties

@synthesize params;

# pragma mark Schedule Notification

- (void)addNotificationRequestWithIdentifier:(NSString*)identifier timestamp:(NSTimeInterval)timestamp title:(NSString*)title body:(NSString*)body  soundNamed:(NSString*)soundName userInfo:(NSString*)userinfo withCompletion:(AddNotificationRequestCompletion)completion {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        [UNUserNotificationCenter.currentNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            switch (settings.authorizationStatus) {
                case UNAuthorizationStatusAuthorized : {
                    NSLog(@"ANX UNAuthorizationStatusAuthorized");
                    UNMutableNotificationContent* content = [UNMutableNotificationContent new];
                    content.title = title;
                    content.body = body;
                    NSLog(@"ANX soundNamed:%@", soundName);
                    if (soundName) {
                        content.sound = [UNNotificationSound soundNamed:soundName];
                    } else {
                        content.sound = [UNNotificationSound defaultSound];
                    }
                    NSLog(@"ANX sound to play:%@", content.sound);
                    content.userInfo = @{@"params" : userinfo};
                    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timestamp repeats:NO];
                    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
                    [UNUserNotificationCenter.currentNotificationCenter addNotificationRequest:request withCompletionHandler:completion];
                    NSLog(@"ANX notification requested");
                    if (completion) {
                        completion(nil);
                    }
                    break;
                }
                case UNAuthorizationStatusDenied : {
                    NSLog(@"ANX UNAuthorizationStatusDenied");
                    if (completion) {
                        completion([NSError errorWithDomain:ANXNotificationCenterErrorDomain code:1001 userInfo:@{NSLocalizedDescriptionKey:@"Access denied"}]);
                    }
                    break;
                }
                case UNAuthorizationStatusNotDetermined : {
                    NSLog(@"ANX UNAuthorizationStatusNotDetermined");
                    if (completion) {
                        completion([NSError errorWithDomain:ANXNotificationCenterErrorDomain code:1002 userInfo:@{NSLocalizedDescriptionKey:@"Unauthorized access"}]);
                    }
                    break;
                }
            }
        }];
    } else {
        
    }
}

- (void)removePendingNotificationRequestWithIdentifiers:(NSArray*)identifiers {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        [UNUserNotificationCenter.currentNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                [UNUserNotificationCenter.currentNotificationCenter removePendingNotificationRequestsWithIdentifiers:identifiers];
            }
        }];
    } else {
    }
}

- (void)removeAllPendingRequests {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        [UNUserNotificationCenter.currentNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                [UNUserNotificationCenter.currentNotificationCenter removeAllPendingNotificationRequests];
            }
        }];
    } else {
        
    }
}

@end

#pragma mark ANXNotificationCenterDelegate

@implementation ANXNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    NSLog(@"ANXNotificationCenter userNotificationCenter:willPresentNotification:withCompletionHandler");
    
    if (completionHandler) {
        completionHandler(UNNotificationPresentationOptionNone);
    }
    
    NSString* params = notification.request.content.userInfo[@"params"];
    
    [ANXDeviceInfo.sharedInstance dispatch:@"DeviceInfo.NotificationCenter.Notification.ReceivedInForeground" withLevel:params];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    NSLog(@"ANXNotificationCenter userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler");
    
    UNNotification* notification = response.notification;
    
    NSString* params = notification.request.content.userInfo[@"params"];
    
    if (ANXNotificationCenter.isInForeground) {
        [ANXDeviceInfo.sharedInstance dispatch:@"DeviceInfo.NotificationCenter.Notification.ReceivedInBackground" withLevel:params];
    } else {
        ANXNotificationCenter.sharedInstance.params = params;
    }
    
    if (completionHandler) {
        completionHandler();
    }
}

@end
