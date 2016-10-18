//
//  RedView.m
//  ResponderDemo
//
//  Created by 杨晴贺 on 8/10/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "RedView.h"

@implementation RedView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Red View Touch") ;
    [super touchesBegan:touches withEvent:event] ;
}

@end
