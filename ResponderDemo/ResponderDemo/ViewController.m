//
//  ViewController.m
//  ResponderDemo
//
//  Created by 杨晴贺 on 8/10/16.
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"ViewController Touch") ;
    [super touchesBegan:touches withEvent:event] ;
}

@end
