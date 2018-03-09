//
//  UITestViewController.m
//  Crash
//
//  Created by Silence on 2018/3/9.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "UITestViewController.h"

@interface UITestViewController ()

@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation UITestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)changeFrame:(id)sender {
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        self.testView.frame = CGRectMake(0, 0, 100, 100);
        self.testView.center = self.view.center;
    });

}

@end
