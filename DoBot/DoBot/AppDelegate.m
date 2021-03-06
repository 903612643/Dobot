//
//  AppDelegate.m
//  DoBot
//
//  Created by 羊德元 on 16/7/14.
//  Copyright © 2016年 羊德元. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "WebViewController.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //    创建窗口
    //    [UIScreen mainScreen].bounds] 获取屏幕的整个大小
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    self.window.backgroundColor = [UIColor whiteColor];
    

    self.window.windowLevel = UIWindowLevelStatusBar;
    
    //状态栏字体白色，＊ios7之前
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    
    //屏幕保持唤醒状态
    [[UIApplication sharedApplication]setIdleTimerDisabled:YES];
    
    self.window.rootViewController=[[HomeViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSLog(@"applicationWillResignActive");
    
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    NSLog(@"applicationDidEnterBackground");

    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSLog(@"applicationWillEnterForeground");
    
   // self.window.rootViewController=[[HomeViewController alloc] init];
   // [self.window makeKeyAndVisible];
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSLog(@"applicationDidBecomeActive");
    

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    NSLog(@"applicationWillTerminate");
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
