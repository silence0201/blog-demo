//
//  RCShopHelperView.m
//  RCShopHelper
//
//  Created by 游侠 on 15/8/23.
//  Copyright © 2015年 YL. All rights reserved.
//

#import "RCShopHelperView.h"


@implementation  IB_DESIGNABLE RCShopHelperView
- (void)awakeFromNib {
    if ([self initWithFrame:self.frame]) {
    }
}
- (id) initWithFrame:(CGRect)frame {

    CGRect rect = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), ((CGRectGetWidth(frame) > 130)?CGRectGetWidth(frame):130), ((CGRectGetHeight(frame) > 30)?CGRectGetHeight(frame):30));
    if (self = [super initWithFrame:rect]) {
        CGFloat btnWidth = CGRectGetHeight(rect)+10;
        _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _minusButton.frame = CGRectMake(0, 0, btnWidth, CGRectGetHeight(rect));
        [_minusButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _minusButton.tag = 12301;
        [self addSubview:_minusButton];
        
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(btnWidth, 0, rect.size.width-2*btnWidth, CGRectGetHeight(rect))];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.adjustsFontSizeToFitWidth = YES;
        _countLabel.text = @"0";
        [self addSubview:_countLabel];
        
        _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _plusButton.frame = CGRectMake(rect.size.width-btnWidth, 0, btnWidth, CGRectGetHeight(rect));
        _plusButton.tag = 12302;
        [_plusButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_plusButton];
        
        

    }
    return self;
}

- (void)buttonClick:(UIButton*)btn {
    if (btn.tag == 12301) {
        if (_count >= 1)
            [self setCount:_count-1];

    }
    else if(btn.tag == 12302){
        if (_count < _maxCount) {
           [self setCount:_count+1];
        }
    }
    _countLabel.text = [NSString stringWithFormat:@"%d",(int)_count];
    
//    if (_count == 0) {
//        [_minusButton setImage:_minusDefaultImage forState:UIControlStateNormal];
//    }
//    else {
//        [_minusButton setImage:_minusDefaultImage forState:UIControlStateNormal];
//    }
//    if (_count == _maxCount) {
//        [_plusButton setImage:_plusDesenableImage forState:UIControlStateNormal];
//    }
//    else{
//        [_plusButton setImage:_plusImage forState:UIControlStateNormal];
//    }
    
    if ([self.delegate respondsToSelector:@selector(valueChanged:)]) {
        [self.delegate valueChanged:_count];
    }
}

- (void)setCount:(NSInteger)count {
    _count = count;
    _countLabel.text = [NSString stringWithFormat:@"%d",(int)_count];
    if (_count == 0) {
        [_minusButton setImage:_minusDefaultImage forState:UIControlStateNormal];
    }
    else {
        [_minusButton setImage:_minusImage forState:UIControlStateNormal];
    }
    
    if (_count == _maxCount) {
        [_plusButton setImage:_plusDesenableImage forState:UIControlStateNormal];
    }
    else{
        [_plusButton setImage:_plusImage forState:UIControlStateNormal];
    }
}
@end
