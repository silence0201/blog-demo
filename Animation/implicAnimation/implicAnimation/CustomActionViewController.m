//
//  CustomActionViewController.m
//  implicAnimation
//
//  Created by 杨晴贺 on 14/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "CustomActionViewController.h"

@interface CustomActionViewController ()
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (nonatomic,strong) CALayer *colorLayer ;

@end

@implementation CustomActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //create sublayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = self.containView.bounds ;
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add a custom action
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor": transition};
    //add it to our view
    [self.containView.layer addSublayer:self.colorLayer];
}

- (IBAction)chageColor:(id)sender {
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
}

@end
