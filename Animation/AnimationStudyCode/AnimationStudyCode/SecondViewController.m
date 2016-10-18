//
//  SecondViewController.m
//  AnimationStudyCode
//
//  Created by 杨晴贺 on 11/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (nonatomic,strong) UIView *redView ;
@property (nonatomic,strong) UIView *greenView ;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"Z坐标演示" ;
    
    self.redView = [[UIView alloc]initWithFrame:CGRectMake(110, 110, 100, 100) ];
    self.redView.backgroundColor = [UIColor redColor] ;
    [self.view addSubview:_redView] ;
    
    self.greenView = [[UIView alloc] initWithFrame:CGRectMake(150, 150, 100, 100)] ;
    self.greenView.backgroundColor = [UIColor greenColor] ;
    [self.view addSubview:_greenView] ;
    
    NSLog(@"%f===%f",self.redView.layer.zPosition,self.greenView.layer.zPosition) ;
    self.redView.layer.zPosition = 1.0f ;
    NSLog(@"%f===%f",self.redView.layer.zPosition,self.greenView.layer.zPosition) ;
}
// containsPoint
/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject]locationInView:self.view] ;
    point = [self.redView.layer convertPoint:point fromLayer:self.view.layer] ;
    if ([self.redView.layer containsPoint:point]) {
        NSLog(@"Inside Red Layer") ;
    }else{
        NSLog(@"Outside Layer") ;
    }
}
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject]locationInView:self.view] ;
    CALayer *layer = [self.view.layer hitTest:point] ;
    if(layer == self.redView.layer){
        NSLog(@"Inside Red Layer") ;
    }else if(layer == self.greenView.layer){
        NSLog(@"Inside Green Layer") ;
    }else{
        NSLog(@"Outside Layer") ;
    }
}


@end
