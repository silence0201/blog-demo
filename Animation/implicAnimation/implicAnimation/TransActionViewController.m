//
//  TransActionViewController.m
//  implicAnimation
//
//  Created by 杨晴贺 on 14/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TransActionViewController.h"

@interface TransActionViewController ()
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (nonatomic,strong) CALayer *colorLayer ;

@end

@implementation TransActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //create sublayer
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = self.colorView.bounds;
    colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.colorView.layer addSublayer:colorLayer];
    self.colorLayer = colorLayer ;
//    UIView *view = [[UIView alloc]init] ;
//    [self.colorView addSubview:view] ;
//    NSLog(@"%ld",self.colorView.subviews.count) ;
}
- (IBAction)chageColor:(id)sender {
    // begin a new transaction
    [CATransaction begin];
    // set the animation duration to 1 second
    [CATransaction setAnimationDuration:1.0];
    //add the spin animation on completion
    [CATransaction setCompletionBlock:^{
        //rotate the layer 90 degrees
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI);
        self.colorLayer.affineTransform = transform;
    }];
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    // commit the transaction
    [CATransaction commit];
}


@end
