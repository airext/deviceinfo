//
//  ANXDeviceInfoAlert.h
//  DeviceInfo
//
//  Created by Max Rozdobudko on 12/2/17.
//  Copyright © 2017 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ANXDeviceInfoAlertShowCompletion)(NSInteger actionIndex);

@interface ANXDeviceInfoAlert : NSObject

+ (void)presentAlertWithTitle:(NSString*)title message:(NSString*)message preferredStyle:(UIAlertControllerStyle)preferredStyle withActions:(NSArray*)actionDescriptors animated:(BOOL)animated withCompletion:(ANXDeviceInfoAlertShowCompletion)completion;

+ (void)dismissAlertAnimated:(BOOL)animated;

@end
