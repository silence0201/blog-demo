//
//  Person.m
//  privateProtocolTest
//
//  Created by 杨晴贺 on 9/17/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "Person.h"
#import "Sleep.h"

@interface Person ()<Sleep>

@end

@implementation Person

- (void)sleep{
    NSLog(@"Person Sleep") ;
}

@end
