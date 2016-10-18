//
//  ViewController.m
//  InsertXibView
//
//  Created by 杨晴贺 on 8/12/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "XibView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 先对content进行自动布局
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    // 创建View
    XibView *view = [[XibView alloc]initWithFrame:self.contentView.bounds] ;
    [self.contentView addSubview:view ] ;
    
}


@end
