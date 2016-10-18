//
//  ViewController.m
//  ReplicatorLayerDemo
//
//  Created by 杨晴贺 on 8/11/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame              = CGRectMake(0, 0, 100, 100);
    replicatorLayer.position           = self.view.center;
    replicatorLayer.backgroundColor    = [UIColor grayColor].CGColor;
    
    replicatorLayer.instanceCount      = 3;
    replicatorLayer.instanceTransform  = CATransform3DMakeTranslation(20.0, 0.0, 0.0);
    replicatorLayer.instanceDelay      = 0.33f;
    
    [self.view.layer addSublayer:replicatorLayer];
    
    {
        CALayer *layer        = [CALayer layer];
        layer.frame           = CGRectMake(0, 0, 8, 40);
        layer.backgroundColor = [UIColor redColor].CGColor;
        [replicatorLayer addSublayer:layer];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        animation.toValue           = @(layer.position.y - 25.f);
        animation.duration          = 0.5f;
        animation.autoreverses      = true;
        animation.repeatCount       = CGFLOAT_MAX;
        [layer addAnimation:animation forKey:nil];
    }
}


@end
