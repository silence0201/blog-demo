//
//  SILoading.m
//  LuaViewDemo
//
//  Created by 杨晴贺 on 05/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "SILoading.h"

@interface SILoading()

@property(nonatomic, strong) UIActivityIndicatorView * loading;

@end

@implementation SILoading

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.loading = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.loading sizeToFit];
        [self.loading startAnimating];
        [self addSubview:self.loading];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.loading) {
        self.loading.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
}

@end
