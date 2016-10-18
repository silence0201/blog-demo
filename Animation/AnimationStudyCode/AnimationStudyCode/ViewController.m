//
//  ViewController.m
//  AnimationStudyCode
//
//  Created by 杨晴贺 on 10/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CALayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self simpleTest] ;
    [self contentTest] ;
}

- (void)simpleTest{
    CALayer *blueLayer = [CALayer layer] ;
    blueLayer.frame = CGRectMake(50, 50, 100, 100) ;
    blueLayer.backgroundColor = [UIColor blueColor].CGColor ;
    
    blueLayer.delegate = self ;
    
    [self.layerView.layer addSublayer:blueLayer] ;
    
    //force layer to redraw
    [blueLayer display];
}

- (void)contentTest{
    UIImage *image = [UIImage imageNamed:@"p"] ;
    // self.view.contentMode = UIViewContentModeScaleAspectFill ;
    // 和上面实现的效果一样
    self.view.layer.contentsGravity = kCAGravityResizeAspectFill ;
    self.view.layer.contentsScale = image.scale ;
    
    self.view.layer.contents = (__bridge id _Nullable)(image.CGImage) ;
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

@end
