//
//  MyCollectionViewCell.m
//  CollectionDemo
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataDic:(NSDictionary *)dataDic{
    self.image.image = [UIImage imageNamed:dataDic[@"image"]] ;
    self.label.text = dataDic[@"title"] ;
    _dataDic = dataDic ;
}

@end
