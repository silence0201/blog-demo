//
//  BlueView.m
//  ResponderDemo
//
//  Created by 杨晴贺 on 8/10/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "BlueView.h"

@implementation BlueView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Blue View Touch") ;
    [super touchesBegan:touches withEvent:event] ;
}

@end
