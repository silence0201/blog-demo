//
//  TwoCustomCell.m
//  CustomDeleteDemo
//
//  Created by 杨晴贺 on 17/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TwoCustomCell.h"
#import "Masonry.h"

@implementation TwoCustomCell

- (void)awakeFromNib {
    [super awakeFromNib] ;
}


- (void)layoutSubviews{
    [super layoutSubviews] ;
    for(UIView *view in self.subviews){
        NSLog(@"%@",view) ;
        view.backgroundColor = [UIColor clearColor] ;
        if([view isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]){
            for(UIView *vi in view.subviews){
                NSLog(@"%@",vi) ;
                if([vi isKindOfClass:[UIButton class]]){
                    UIImage *image = [UIImage imageNamed:@"delete"] ;
                    UIButton *btn = (UIButton *)vi ;
                    [btn setTitle:@"删除" forState:UIControlStateNormal] ;
                    btn.backgroundColor = [UIColor clearColor] ;
                    [btn setImage:image forState:UIControlStateNormal] ;
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.left.bottom.right.equalTo(view) ;
                    }] ;
                }
            }
        }
    }
}

@end
