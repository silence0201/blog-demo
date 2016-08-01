//
//  SessionViewController.m
//  weixin
//
//  Created by 杨晴贺 on 8/1/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SessionViewController.h"

@interface SessionViewController ()

/**
 *  返回到跳转过来的APP
 */
- (IBAction)backToApp;

@end

@implementation SessionViewController

- (IBAction)backToApp {
    NSRange range = [self.appURLStr rangeOfString:@"?"];
    NSString *appStr = [self.appURLStr substringFromIndex:(range.location + 1)];
    
    NSString *appURL = [NSString stringWithFormat:@"%@://", appStr];
    
    NSURL *url = [NSURL URLWithString:appURL];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
@end
