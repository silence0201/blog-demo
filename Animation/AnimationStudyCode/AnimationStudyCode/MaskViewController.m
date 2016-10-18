//
//  MaskViewController.m
//  AnimationStudyCode
//
//  Created by 杨晴贺 on 11/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MaskViewController.h"

@interface MaskViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // create mask layer
    CALayer *maskLayer = [CALayer layer] ;
    maskLayer.frame = self.imageView.bounds ;
    UIImage *maskImage = [UIImage imageNamed:@"mask"] ;
    maskLayer.contents = (__bridge id _Nullable)(maskImage.CGImage) ;
    
    // apply mask to imageView
    self.imageView.layer.mask = maskLayer ;
}


@end
