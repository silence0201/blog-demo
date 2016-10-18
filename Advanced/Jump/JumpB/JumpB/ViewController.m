//
//  ViewController.m
//  JumpB
//
//  Created by 杨晴贺 on 8/1/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)jumpToA {
    NSString *paramStr = [NSString stringWithFormat:@"A://username=%@&age=%@&address=%@", @"小明", @"20", @"上海市"];
    NSURL *jumpUrl = [NSURL URLWithString:[paramStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
    // 应用的跳转
    [[UIApplication sharedApplication] openURL:jumpUrl] ;
}

@end
