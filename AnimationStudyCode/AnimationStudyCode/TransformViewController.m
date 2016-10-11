//
//  TransformViewController.m
//  AnimationStudyCode
//
//  Created by 杨晴贺 on 11/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TransformViewController.h"

@interface TransformViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;


@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",NSStringFromCGRect(self.imageView.frame)) ;
    NSLog(@"%@",NSStringFromCGRect(self.imageView.bounds)) ;
    self.imageView.transform = CGAffineTransformMakeRotation(M_PI_4) ;
    NSLog(@"%@",NSStringFromCGRect(self.imageView.frame)) ;
    NSLog(@"%@",NSStringFromCGRect(self.imageView.bounds)) ;
    
    //create a new transform
    CATransform3D transform = CATransform3DIdentity;
    //apply perspective
    transform.m34 = - 1.0 / 500.0;
    //rotate by 45 degrees along the Y axis
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, -0.5);
    //apply to layer
    self.imageView2.layer.transform = transform;
    
}


@end
