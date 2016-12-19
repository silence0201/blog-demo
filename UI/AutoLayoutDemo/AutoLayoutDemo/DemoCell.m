//
//  DemoCell.m
//  AutoLayoutDemo
//
//  Created by 杨晴贺 on 19/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "DemoCell.h"
#import "UIView+SDAutoLayout.h"

@implementation DemoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup] ;
    }
    return self ;
}

- (void)setup{
    UILabel *titleLabel = [UILabel new] ;
    titleLabel.textColor = [UIColor redColor] ;
    titleLabel.font = [UIFont systemFontOfSize:15] ;
    [self.contentView addSubview:titleLabel] ;
    self.titleLabel = titleLabel ;
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.textColor = [UIColor lightGrayColor];
    contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    CGFloat margin = 10 ;
    
    // 设置约束
    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(self.contentView,margin)
    .rightSpaceToView(self.contentView,margin)
    .heightIs(20)  ;
    
    self.contentLabel.sd_layout
    .leftEqualToView(self.titleLabel)
    .rightEqualToView(self.titleLabel)
    .topSpaceToView(self.titleLabel,margin)
    .autoHeightRatio(0) ;
    
    [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:margin] ;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
