//
//  ANXDeviceInfoScreen.m
//  DeviceInfo
//
//  Created by Max Rozdobudko on 3/11/18.
//  Copyright © 2018 Max Rozdobudko. All rights reserved.
//

#import "ANXDeviceInfoScreen.h"
#import "ANXDeviceInfo.h"

@implementation ANXDeviceInfoScreen

+ (UIEdgeInsets)getSafeArea {
    UIWindow* window = UIApplication.sharedApplication.delegate.window;
    if (window == nil) {
        NSLog(@"ANXDeviceInfoScreen.getSafeArea no window");
        return UIEdgeInsetsZero;
    }

    UIViewController* viewController = window.rootViewController;
    if (viewController == nil) {
        NSLog(@"ANXDeviceInfoScreen.getSafeArea no view controller");
        return UIEdgeInsetsZero;
    }

    UIView* view = window.rootViewController.view;
    if (view == nil) {
        NSLog(@"ANXDeviceInfoScreen.getSafeArea no view");
        return UIEdgeInsetsZero;
    }

    if (isOperatingSystemAtLeast(11, 0, 0)) {
        return view.safeAreaInsets;
    } else {
        return UIEdgeInsetsMake(viewController.topLayoutGuide.length, 0.0, viewController.bottomLayoutGuide.length, 0.0);
    }
}

@end
