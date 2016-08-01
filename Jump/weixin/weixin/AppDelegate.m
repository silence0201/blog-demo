//
//  AppDelegate.m
//  weixin
//
//  Created by 杨晴贺 on 8/1/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *  当通过别应用打开该应用的时候会执行该方法
 *
 *  @param url               通过哪一个URL跳转过来的
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // 取出来根控制器
    UINavigationController *rootNav = (UINavigationController *)self.window.rootViewController;
    
    [rootNav popToRootViewControllerAnimated:NO];
    
    // 取出ViewController
    ViewController *mainVc = [rootNav.childViewControllers firstObject];
    
    NSString *urlStr = url.absoluteString;
    if ([urlStr rangeOfString:@"session"].length) {
        
        mainVc.appURLStr = urlStr;
        
        // 跳转到微信好友界面
        [mainVc performSegueWithIdentifier:@"session" sender:nil];
        
    } else if ([urlStr rangeOfString:@"timeline"].length){
        // 跳转到朋友圈界面
        [mainVc performSegueWithIdentifier:@"timeline" sender:nil];
    }
    
    return YES;
}

@end
