//
//  ThirdViewController.m
//  AnimationStudyCode
//
//  Created by 杨晴贺 on 11/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@property (nonatomic,strong) UIView *view1 ;
@property (nonatomic,strong) UIView *view2 ;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100) ];
    self.view1.backgroundColor = [UIColor grayColor] ;
    [self.view addSubview:_view1] ;
    CALayer *layer1 = [CALayer layer] ;
    layer1.frame = CGRectMake(-10, -10, 50, 50) ;
    layer1.backgroundColor = [UIColor redColor].CGColor ;
    [self.view1.layer addSublayer:layer1] ;
    self.view1.layer.cornerRadius = 20 ;
    self.view1.layer.borderWidth = 5 ;

    
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 100, 100) ];
    self.view2.backgroundColor = [UIColor lightGrayColor] ;
    [self.view addSubview:_view2] ;
    CALayer *layer2 = [CALayer layer] ;
    layer2.frame = CGRectMake(-10, -10, 50, 50) ;
    layer2.backgroundColor = [UIColor redColor].CGColor ;
    [self.view2.layer addSublayer:layer2] ;
    self.view2.layer.cornerRadius = 20 ;
    self.view2.layer.borderWidth = 5 ;
    self.view2.layer.masksToBounds = YES ;
}


@end
