//
//  UMSLoginTableViewController.h
//  SocialSDK
//
//  Created by umeng on 16/4/25.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UMSocialCore/UMSocialCore.h>

@interface UMSLoginTableViewController : UITableViewController


@end


@interface UMSocialAthoTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *platformLabel;

@property (nonatomic, strong) UISwitch *platformSwitch;

@property (nonatomic, assign) NSInteger platformType;

@property (nonatomic, copy) void (^switchAction)(UISwitch *platformSwitch, NSInteger platformType);

@end