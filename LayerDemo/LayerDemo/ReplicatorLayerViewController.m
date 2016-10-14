//
//  ReplicatorLayerViewController.m
//  LayerDemo
//
//  Created by 杨晴贺 on 13/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ReplicatorLayerViewController.h"

@interface ReplicatorLayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *shapeView;

@end

@implementation ReplicatorLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //create a replicator layer and add it to our view
    CAReplicatorLayer *shapeReplicator = [CAReplicatorLayer layer];
    shapeReplicator.frame = self.shapeView.bounds;
    [self.shapeView.layer addSublayer:shapeReplicator];
    self.shapeView.layer.masksToBounds = YES ;
    
    //configure the replicator
    shapeReplicator.instanceCount = 3;
    
    //apply a transform for each instance
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 40, 40, 0);
    shapeReplicator.instanceTransform = transform;
    
    //apply a color shift for each instance
    shapeReplicator.instanceBlueOffset = -0.1;
    shapeReplicator.instanceGreenOffset = -0.1;
    
    //create a sublayer and place it inside the replicator
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [shapeReplicator addSublayer:layer];
    
}


@end
