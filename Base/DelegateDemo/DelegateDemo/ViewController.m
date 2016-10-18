//
//  ViewController.m
//  DelegateDemo
//
//  Created by 杨晴贺 on 16/7/17.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "ViewController.h"
#import "TimerControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TimerControl *tc = [[TimerControl alloc]init] ;
    tc.delegate = self ;  //设置委托实例
    
    //实现block
    tc.updateAlterBlock = ^()
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"时间到" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        alert.alertViewStyle=UIAlertViewStyleDefault;
        [alert show];
    };
    [tc startTheTimer] ;
}

//实现对应的委托必选方法
- (void)updateAlert
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"时间到" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    alert.alertViewStyle=UIAlertViewStyleDefault;
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
