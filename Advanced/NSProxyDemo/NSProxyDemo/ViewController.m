//
//  ViewController.m
//  NSProxyDemo
//
//  Created by 杨晴贺 on 2017/6/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "DealerProxy.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DealerProxy *dealerProxy = [DealerProxy dealerProxy];
    [dealerProxy purchaseBookWithTitle:@"Swift 100 Tips"];
    [dealerProxy purchaseClothesWithSize:ClothesSizeMedium];
}


@end
