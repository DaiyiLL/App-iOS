//
//  AppDelegate.m
//  01_SlideMenu
//
//  Created by yidai on 2020/8/14.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, assign) UIEdgeInsets safe;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (UIEdgeInsets)safe {
    if (UIEdgeInsetsEqualToEdgeInsets(_safe, UIEdgeInsetsZero)) {
        _safe = UIEdgeInsetsMake(20, 0, 0, 0);
        UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
        if (@available(iOS 11.0, *)) {
            _safe = keyWindow.safeAreaInsets;
        }
        if (_safe.top < 20) {
            // 预防iOS11上top为0的情况
            _safe.top = 20;
        }
    }
    return _safe;
}


+ (UIEdgeInsets)safeInset {
    AppDelegate *delegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
    return delegate.safe;
}

@end
