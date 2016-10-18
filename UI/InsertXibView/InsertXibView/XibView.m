//
//  XibView.m
//  InsertXibView
//
//  Created by 杨晴贺 on 8/12/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "XibView.h"

@implementation XibView

// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"XibView" owner:nil options:nil]lastObject] ;
        [self addSubview:view] ;
        view.frame = self.bounds ;
    }
    return self ;
}

@end
