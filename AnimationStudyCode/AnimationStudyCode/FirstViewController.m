//
//  FirstViewController.m
//  AnimationStudyCode
//
//  Created by 杨晴贺 on 10/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (nonatomic,strong) UIView *firstView ;
@property (nonatomic,strong) UIView *secondView ;
@property (nonatomic,strong) UIView *thirdView ;
@property (nonatomic,strong) UIView *forthView ;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat height = [UIScreen mainScreen].bounds.size.height ;
    CGFloat width = [UIScreen mainScreen].bounds.size.width ;
    self.firstView = [[UIView alloc]initWithFrame:CGRectMake(20, 100,150 , 150)] ;
    self.firstView.backgroundColor = [UIColor redColor] ;
    
    self.secondView = [[UIView alloc]initWithFrame:CGRectMake(width/2,100,150 , 150)] ;
    self.secondView.backgroundColor = [UIColor grayColor] ;
    
    self.thirdView = [[UIView alloc]initWithFrame:CGRectMake(20, height/2, 150, 150) ];
    self.thirdView.backgroundColor = [UIColor blueColor] ;
    
    self.forthView = [[UIView alloc]initWithFrame:CGRectMake(width/2, height/2, 150, 150)] ;
    self.forthView.backgroundColor = [UIColor greenColor] ;
    
    [self.view addSubview:_firstView] ;
    [self.view addSubview:_secondView] ;
    [self.view addSubview:_thirdView] ;
    [self.view addSubview:_forthView] ;
    
    UIImage *image = [UIImage imageNamed:@"pp"];
    //set igloo sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.firstView.layer];
    //set cone sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:self.secondView.layer];
    //set anchor sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:self.thirdView.layer];
    //set spaceship sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:self.forthView.layer];
}

- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer{
    // set image
    layer.contents = (__bridge id _Nullable)(image.CGImage) ;
    // scale content to fit
    layer.contentsGravity = kCAGravityResizeAspectFill ;
    // set contentsRect
    layer.contentsRect = rect ;
}



@end
