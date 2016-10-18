//
//  ViewController.m
//  ScrollerViewXibDemo
//
//  Created by 杨晴贺 on 23/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewwidth;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 更新约束
- (void)updateViewConstraints{
    [super updateViewConstraints] ;
    self.viewWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width * 2 ;
    self.viewwidth.constant = [UIScreen mainScreen].bounds.size.width ;
}


@end
