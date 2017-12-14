//
//  ANXNotificationCenter.h
//  DeviceInfo
//
//  Created by Max Rozdobudko on 12/7/17.
//  Copyright © 2017 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

extern NSErrorDomain ANXNotificationCenterErrorDomain;

typedef void(^GetNotificationSettingsCompletion)(NSString *authorizationStatus);
typedef void(^RequestAuthorizationCompletion)(BOOL granted, NSError* error);
typedef void(^AddNotificationRequestCompletion)(NSError* error);

@interface ANXNotificationCenter : NSObject

# pragma mark Shared instance

+ (ANXNotificationCenter*)sharedInstance;

# pragma mark Availability & Permissions

+ (BOOL)isSupported;

+ (BOOL)isEnabled;

+ (BOOL)canOpenSettings;
+ (void)openSettings;

+ (void)getNotificationSettingsWithCompletion:(GetNotificationSettingsCompletion)completion;
+ (void)requestAuthorizationWithOPtions:(NSInteger)options withCompletion:(RequestAuthorizationCompletion)completion;

# pragma mark Background / Foreground

+ (BOOL)isInForeground;
+ (void)inForeground;
+ (void)inBackground;

# pragma mark Properties

@property NSString* params;

# pragma mark Schedule Notification

- (void)addNotificationRequestWithIdentifier:(NSString*)identifier timestamp:(NSTimeInterval)timestamp title:(NSString*)title body:(NSString*)body userInfo:(NSString*)userinfo withCompletion:(AddNotificationRequestCompletion)completion;
- (void)removePendingNotificationRequestWithIdentifiers:(NSArray*)identifiers;
- (void)removeAllPendingRequests;

@end

#pragma mark ANXNotificationCenterDelegate

@interface ANXNotificationCenterDelegate: NSObject <UNUserNotificationCenterDelegate>
@end
