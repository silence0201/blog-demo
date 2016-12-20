//
//  ViewController.m
//  UMAnalyticsDemo
//
//  Created by 杨晴贺 on 20/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import <UMMobClick/MobClick.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass(self.class)];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass(self.class)];
}

- (IBAction)clickAction:(id)sender {
    NSLog(@"Click") ;
    [MobClick event:@"BtnClick"] ;
}

- (IBAction)exception:(id)sender {
    NSArray *array = [NSArray array];
    [array objectAtIndex:NSUIntegerMax];
}


@end
