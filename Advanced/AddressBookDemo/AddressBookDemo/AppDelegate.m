//
//  AppDelegate.m
//  AddressBookDemo
//
//  Created by 杨晴贺 on 8/21/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import <AddressBook/AddressBook.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1.获取用户的授权状态
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    // 2.如果授权状态是未决定的,则请求授权
    if (status == kABAuthorizationStatusNotDetermined) {
        // 2.1.获取通信录对象
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        
        // 2.2.请求授权
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (granted) {
                NSLog(@"用户授权成功");
            } else {
                NSLog(@"用户授权失败");
            }
        });
    }
    
    return YES;
}


@end
