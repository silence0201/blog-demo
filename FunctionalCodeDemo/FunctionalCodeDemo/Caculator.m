//
//  Caculator.m
//  FunctionalCodeDemo
//
//  Created by 杨晴贺 on 24/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "Caculator.h"

@implementation Caculator

- (instancetype)add:(int (^)(int))block{
    _result = block(_result) ;
    return self ;
}

- (instancetype)equal:(BOOL (^)(int))block{
    _isEqual = block(_result) ;
    return self ;
}

@end
