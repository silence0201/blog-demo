//
//  ViewController.m
//  xibNewDemo
//
//  Created by 杨晴贺 on 8/19/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// IBInspectable 可以通过xib改变代码里面的值
@property (nonatomic,strong) IBInspectable NSString *name ;
@property (nonatomic,strong) IBInspectable NSString *password ;

// 可以把一类对象放在一个数组中
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@---%@",self.name,self.password) ;
    
    
    [self.btnArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"index:%lud",(unsigned long)idx) ;
        NSLog(@"title:%@",obj.currentTitle) ;
    }];
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    NSLog(@"tap") ;
    NSLog(@"%@",NSLocalizedString(@"hello", nil)) ;
}


@end
