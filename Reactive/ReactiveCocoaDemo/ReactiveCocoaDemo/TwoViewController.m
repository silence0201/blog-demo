//
//  TwoViewController.m
//  ReactiveCocoaDemo
//
//  Created by 杨晴贺 on 24/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TwoViewController.h"

@implementation TwoViewController
- (IBAction)btnClick:(id)sender {
    // 通知ViewcController做事情
    if(self.subject){
        [self.subject sendNext:nil] ;
    }
}

@end
