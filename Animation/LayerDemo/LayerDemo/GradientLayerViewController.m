//
//  GradientLayerViewController.m
//  LayerDemo
//
//  Created by 杨晴贺 on 13/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "GradientLayerViewController.h"

@interface GradientLayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UIView *locView;

@end

@implementation GradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // create gradient layer and add it
    CAGradientLayer *gradientLayer = [CAGradientLayer layer] ;
    gradientLayer.frame = self.containView.bounds ;
    [self.containView.layer addSublayer:gradientLayer] ;
    
    // set gradient colors
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    
    // set gradient start and end points
    gradientLayer.startPoint = CGPointMake(0, 0) ;
    gradientLayer.endPoint = CGPointMake(1, 1) ;
    
    //create gradient layer and add it to our container view
    CAGradientLayer *locgradientLayer = [CAGradientLayer layer];
    locgradientLayer.frame = self.locView.bounds;
    [self.locView.layer addSublayer:locgradientLayer];
    
    //set gradient colors
    locgradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id) [UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    
    //set locations
    locgradientLayer.locations = @[@0.0, @0.75, @1];
    
    //set gradient start and end points
    locgradientLayer.startPoint = CGPointMake(0, 0);
    locgradientLayer.endPoint = CGPointMake(1, 1);
}


@end
