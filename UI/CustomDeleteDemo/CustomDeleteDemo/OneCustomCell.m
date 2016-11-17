//
//  OneCustomCell.m
//  CustomDeleteDemo
//
//  Created by 杨晴贺 on 17/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "OneCustomCell.h"
#import "Masonry.h"

@implementation OneCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UIView *deleView = [[UIView alloc]init] ;
        deleView.backgroundColor = [UIColor whiteColor] ;
        
        UIButton *deleBtn = [[UIButton alloc]init] ;
        [deleBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside] ;
        [deleView addSubview:deleBtn] ;
        [self.contentView addSubview:deleView] ;
        
        typeof(self) __weak weakSelf = self ;
        [deleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset([UIScreen mainScreen].bounds.size.width) ;
            make.top.equalTo(weakSelf.contentView) ;
            make.bottom.equalTo(weakSelf.contentView).offset(1) ;
            make.width.equalTo(weakSelf.contentView) ;
        }] ;
        
        [deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(deleView) ;
            make.width.offset(80) ;
        }] ;
    }
    return self ;
}

- (void)deleteAction{
    NSLog(@"%s",__func__) ;
}

@end
