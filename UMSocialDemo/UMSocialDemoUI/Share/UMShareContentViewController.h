//
//  UMShareContentViewController.h
//  UMSocialSDK
//
//  Created by wangfei on 16/8/9.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMSocialCore/UMSocialCore.h>

@interface UMShareContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *textbtn;
@property (weak, nonatomic) IBOutlet UISwitch *titlebtn;
@property (weak, nonatomic) IBOutlet UISwitch *urlbtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mediabtn;

@property (weak, nonatomic) IBOutlet UIView *contentBgView;


@property (nonatomic, assign) UMSocialPlatformType socialType;

@end
