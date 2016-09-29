//
//  RouteTableViewCell.m
//  officialDemo2D
//
//  Created by KuangYe on 15/11/18.
//  Copyright © 2015年 AutoNavi. All rights reserved.
//

#import "RouteTableViewCell.h"
#import "PureLayout.h"

@implementation RouteTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"路线";
        label.textColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        [self.contentView addSubview:label];
        
        [label autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [label autoSetDimension:ALDimensionWidth toSize:100];
        
        UIButton *busBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [busBtn setBackgroundImage:[UIImage imageNamed:@"bus"] forState:UIControlStateNormal];
        [busBtn setTag:kBusBtnTag];
        [busBtn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:busBtn];
        
        UIButton *walkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [walkBtn setBackgroundImage:[UIImage imageNamed:@"man"] forState:UIControlStateNormal];
        [walkBtn setTag:kWalkBtnTag];
        [walkBtn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:walkBtn];
        
        UIButton *driveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [driveBtn setBackgroundImage:[UIImage imageNamed:@"car"] forState:UIControlStateNormal];
        [driveBtn setTag:kDriveBtnTag];
        [driveBtn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:driveBtn];
        
        [busBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [busBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [busBtn autoSetDimension:ALDimensionWidth toSize:28];
        
        [walkBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [busBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:walkBtn withOffset:15];
        [walkBtn autoSetDimension:ALDimensionWidth toSize:28];
        
        [driveBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [walkBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:driveBtn withOffset:15];
        [driveBtn autoSetDimension:ALDimensionWidth toSize:28];
    
    }
    return self;
}

- (void)buttonTapped:(UIButton *)sender
{
    [self.delegate cellButtonDidTapped:sender];
}

@end
