//
//  ANXDeviceInfoAlert.m
//  DeviceInfo
//
//  Created by Max Rozdobudko on 12/2/17.
//  Copyright © 2017 Max Rozdobudko. All rights reserved.
//

#import "ANXDeviceInfoAlert.h"
#import <UIKit/UIKit.h>

@implementation ANXDeviceInfoAlert

static NSMutableDictionary* alertControllers;

+ (void)presentAlertWithTitle:(NSString*)title message:(NSString*)message preferredStyle:(UIAlertControllerStyle)preferredStyle withActions:(NSArray*)actionDescriptors animated:(BOOL)animated withCompletion:(ANXDeviceInfoAlertShowCompletion)completion {
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    for (NSDictionary* actionDescriptor in actionDescriptors) {
        UIAlertAction* action = [UIAlertAction actionWithTitle:[actionDescriptor objectForKey:@"title"] style:[[actionDescriptor objectForKey:@"style"] integerValue] handler:^(UIAlertAction * _Nonnull action) {
            if (completion) {
                completion([[actionDescriptor objectForKey:@"index"] integerValue]);
            }
        }];
        action.enabled = [[actionDescriptor objectForKey:@"enabled"] boolValue];
        [alertController addAction:action];
    }
    
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    [rootViewController presentViewController:alertController animated:animated completion:nil];
}

+ (void)dismissAlertAnimated:(BOOL)animated {
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if ([rootViewController.presentedViewController isKindOfClass:UIAlertController.class]) {
        [rootViewController.presentedViewController dismissViewControllerAnimated:animated completion:nil];
    }
}

@end
