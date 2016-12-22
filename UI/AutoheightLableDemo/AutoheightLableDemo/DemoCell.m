//
//  DemoCell.m
//  AutoheightLableDemo
//
//  Created by 杨晴贺 on 22/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "DemoCell.h"
#import "SDAutoLayout.h"

@interface DemoCell ()

@property (weak, nonatomic) IBOutlet UILabel *content1;
@property (weak, nonatomic) IBOutlet UILabel *content2;


@end

@implementation DemoCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr ;
    self.content1.text = contentStr ;
    self.content2.text = contentStr ;
    [self setupAutoHeightWithBottomView:self.content2 bottomMargin:10];
}
@end
