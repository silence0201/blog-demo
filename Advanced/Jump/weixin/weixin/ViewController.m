//
//  ViewController.m
//  weixin
//
//  Created by 杨晴贺 on 8/1/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "SessionViewController.h"

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"session"]) {
        SessionViewController *sessionVc = segue.destinationViewController;
        sessionVc.appURLStr = self.appURLStr;
    }
}

@end
