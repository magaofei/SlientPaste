//
//  AppDelegate.m
//  SlientPaste
//
//  Created by MAMIAN on 2017/1/10.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [AVOSCloud setApplicationId:@"1hIiJtArKnGFGHNUfMOylot9-gzGzoHsz" clientKey:@"X0UaQjG5nbgAOtXlGoP9RsyU"];
    
    [self registerPush];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Push


- (void)registerPush {
    
    // iOS8 以后
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil]];
    } else {
        // iOS7 及之前
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound];
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 去掉先后尖括号和中间的空格
    NSString *token = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"DeviceToken string, %@", token);
    
    [AVOSCloud handleRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    UIPasteboard *pastedBoard = [UIPasteboard generalPasteboard];
    // 静默通知还是普通推送
    if ([userInfo objectForKey:@"content"]) {
        
        NSString *s = [userInfo objectForKey:@"content"];
        [pastedBoard setString:s];
    } else {
        
        if ([userInfo objectForKey:@"aps"]) {
            if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]) {
                NSString *s = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
                [pastedBoard setString:s];
            }
        }
        
        
    }
    
    
}

@end
