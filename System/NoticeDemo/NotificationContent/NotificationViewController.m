//
//  NotificationViewController.m
//  NotificationContent
//
//  Created by 杨晴贺 on 16/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


// Required. Called when a notification arrives for your app.
- (void)didReceiveNotification:(UNNotification *)notification {
    // 这里可以把所有的东西拿出来
    NSDictionary *dic = notification.request.content.userInfo ;
    NSArray *attachments = notification.request.content.attachments ;
    
    NSLog(@"%@",dic) ;
    NSLog(@"%@",attachments) ;
    
    self.label.text = notification.request.content.body;
}

// Called when the user taps one of the notification actions.
- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption))completion{
    NSLog(@"respone:%@",response) ;
    completion(UNNotificationContentExtensionResponseOptionDismiss) ;
}

// The type of media button type to display.
- (UNNotificationContentExtensionMediaPlayPauseButtonType)mediaPlayPauseButtonType{
    return UNNotificationContentExtensionMediaPlayPauseButtonTypeDefault ;
}

// The frame rectangle to use for displaying a media playback button.
- (CGRect)mediaPlayPauseButtonFrame{
    return CGRectMake(100, 100, 100, 100) ;
}

// The tint color for the media playback button.
- (UIColor *)mediaPlayPauseButtonTintColor{
    return [UIColor blueColor] ;
}

// Called when the user initiates playback of your media content.
- (void)mediaPlay{
    NSLog(@"mediaPlay,开始播放") ;
}

// Called when the user pauses playback of your media content.
- (void)mediaPause{
    NSLog(@"mediaPause，暂停播放") ;
}

@end
