//
//  SIButton.m
//  LuaViewDemo
//
//  Created by 杨晴贺 on 05/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "SIButton.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation SIButton

- (void)setWebImageUrl:(NSString *)url forState:(UIControlState)state finished:(LVLoadFinished)finished{
    [self sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
}


@end
