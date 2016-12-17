//
//  AutoresizingMaskVC.m
//  AutoresizingMaskDemo
//
//  Created by 杨晴贺 on 17/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AutoresizingMaskVC.h"

#define kTopSpace 64
#define kMargin 20

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kUIScreenHeight [UIScreen mainScreen].bounds.size.width

#define kTopViewHeight 44
#define kTopViewWidth 300

@interface AutoresizingMaskVC ()

@end

@implementation AutoresizingMaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(kMargin, kTopSpace, kScreenWidth - 2*kMargin ,50)] ;
    view.backgroundColor = [UIColor redColor] ;
    
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin] ;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, CGRectGetMaxY(view.frame), kScreenWidth - 2*kMargin, 300)] ;
    imageView.image = [UIImage imageNamed:@"Image"] ;
    imageView.clipsToBounds = YES ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    [self.view addSubview:view] ;
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin ] ;
}

@end
