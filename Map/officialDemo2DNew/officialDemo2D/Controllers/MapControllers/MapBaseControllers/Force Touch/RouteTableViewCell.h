//
//  RouteTableViewCell.h
//  officialDemo2D
//
//  Created by KuangYe on 15/11/18.
//  Copyright © 2015年 AutoNavi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBusBtnTag 666
#define kWalkBtnTag 667
#define kDriveBtnTag 668

@protocol RouteTableViewCellDelegate <NSObject>

- (void)cellButtonDidTapped:(UIButton *)button;

@end

@interface RouteTableViewCell : UITableViewCell

@property (nonatomic, weak) id <RouteTableViewCellDelegate> delegate;

@end
