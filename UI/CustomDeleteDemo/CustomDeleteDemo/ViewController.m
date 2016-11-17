//
//  ViewController.m
//  CustomDeleteDemo
//
//  Created by 杨晴贺 on 17/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "OneTableViewController.h"
#import "TwoTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)oneAction:(id)sender {
    [self.navigationController pushViewController:[OneTableViewController new] animated:YES] ;
}

- (IBAction)twoAction:(id)sender {
    [self.navigationController pushViewController:[TwoTableViewController new] animated:YES] ;
}

@end
