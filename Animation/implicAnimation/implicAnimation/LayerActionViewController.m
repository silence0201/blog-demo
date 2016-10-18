//
//  LayerActionViewController.m
//  implicAnimation
//
//  Created by 杨晴贺 on 14/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "LayerActionViewController.h"

@interface LayerActionViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation LayerActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    //test layer action when outside of animation block
    NSLog(@"Outside: %@", [self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]);
    //begin animation block
    [UIView beginAnimations:nil context:nil];
    //test layer action when inside of animation block
    NSLog(@"Inside: %@", [self.layerView actionForLayer:self.layerView.layer forKey:@"backgroundColor"]);
    //end animation block
    [UIView commitAnimations];
}

- (IBAction)chageColor:(id)sender {
    /* 没有动画效果
    //begin a new transaction
    [CATransaction begin];
    //set the animation duration to 1 second
    [CATransaction setAnimationDuration:1.0];
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.layerView.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    //commit the transaction
    [CATransaction commit];
     */
    [UIView beginAnimations:nil context:nil] ;
    [UIView setAnimationDuration:1.0] ;
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.layerView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    [UIView commitAnimations] ;
}

@end
