//
//  UpdateConstraintsController.m
//  MasoryDemo
//
//  Created by 杨晴贺 on 12/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "UpdateConstraintsController.h"
#import "Masonry.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface UpdateConstraintsController ()

@property (nonatomic, strong) UIView *constraintsView;
@property (nonatomic, strong) UIView *frameView;
@property (nonatomic, assign) BOOL constrainIsExpend;
@property (nonatomic, assign) BOOL frameIsExpend;

@end

@implementation UpdateConstraintsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.title = @"UpdateConstraintsController" ;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    imageView.image = [UIImage imageNamed:@"4"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]] ;
    visualView.frame = [UIScreen mainScreen].bounds ;
    [imageView addSubview:visualView] ;
    
    
    [self initView] ;
}

- (void)initView{
    typeof(self) __weak weakSelf = self ;
    _constrainIsExpend = NO ;
    _frameIsExpend = NO ;
    
    UIView *constraintView = [[UIView alloc]init] ;
    constraintView.center = self.view.center ;
    constraintView.backgroundColor = [UIColor redColor] ;
    [self.view addSubview:constraintView] ;
    self.constraintsView = constraintView ;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateWithConstraints)] ;
    [constraintView addGestureRecognizer:tap] ;
    [constraintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view) ;
        make.centerY.equalTo(weakSelf.view).offset(-SCREEN_WIDTH/4) ;
        make.size.mas_equalTo(CGSizeMake(100, 100)) ;
    }] ;
    
    UIView *frameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)] ;
    frameView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/4*3);
    frameView.backgroundColor = [UIColor greenColor];
    self.frameView = frameView ;
    [self.view addSubview:frameView] ;
    
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateWithFrame)] ;
    [frameView addGestureRecognizer:taps] ;
}

- (void)updateWithConstraints{
    _constrainIsExpend = !_constrainIsExpend ;
    [self.view setNeedsUpdateConstraints] ;  // 标记为需要更新约束
    [self.view updateConstraintsIfNeeded] ;  // 立即调用updateViewConstraints更新约束, 此方法只是更新了约束, 并没有刷新布局
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded] ;  // 动画刷新布局
    }] ;
}

- (void)updateViewConstraints{
    [self.constraintsView mas_updateConstraints:^(MASConstraintMaker *make) {
        if(_constrainIsExpend){
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT/2)) ;
        }else{
            make.size.mas_equalTo(CGSizeMake(100, 100)) ;
        }
    }] ;
    [super updateViewConstraints] ;
}

- (void)updateWithFrame{
    _frameIsExpend = !_frameIsExpend ;
    CGRect frame ;
    if (_frameIsExpend) {
        frame = CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2) ;
    }else{
        frame = CGRectMake(0, 0, 100, 100) ;
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        self.frameView.frame = frame;
        self.frameView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/4*3);
        
    }];
}

@end
