//
//  RedView.m
//  ThroughTest
//
//  Created by 杨晴贺 on 28/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "RedView.h"

@implementation RedView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击了红色View") ;
    [super touchesBegan:touches withEvent:event] ;
}

@end
