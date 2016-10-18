//
//  XibView.m
//  ViewFromXib
//
//  Created by 杨晴贺 on 8/12/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "XibView.h"

@implementation XibView{
    UIView *_contentView ;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        NSString *className = NSStringFromClass([self class]) ;
        _contentView = [[[NSBundle mainBundle]loadNibNamed:className owner:self options:nil]lastObject] ;
        [self addSubview:_contentView] ;
        
    }
    return self ;
}

@end
