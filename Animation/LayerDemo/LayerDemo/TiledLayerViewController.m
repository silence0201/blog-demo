//
//  TiledLayerViewController.m
//  LayerDemo
//
//  Created by 杨晴贺 on 13/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TiledLayerViewController.h"

@interface TiledLayerViewController ()<CALayerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation TiledLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add the tile layer
    CATiledLayer *tileLayer = [CATiledLayer layer] ;
    tileLayer.frame = CGRectMake(0, 0, 3000, 2000) ;
    tileLayer.delegate = self ;
    [self.scrollView.layer addSublayer:tileLayer] ;
    
    // configure the scroll view
    self.scrollView.contentSize = tileLayer.frame.size ;
    
    // draw layer
    [tileLayer setNeedsDisplay] ;
}

#pragma mark - delegate
- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx{
    //determine tile coordinate
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    NSInteger x = floor(bounds.origin.x / layer.tileSize.width);
    NSInteger y = floor(bounds.origin.y / layer.tileSize.height);
    
    //load tile image
    NSString *imageName = [NSString stringWithFormat: @"Snowman_%02li_%02li", (long)x, (long)y];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
    UIImage *tileImage = [UIImage imageWithContentsOfFile:imagePath];
    
    //draw tile
    UIGraphicsPushContext(ctx);
    [tileImage drawInRect:bounds];
    UIGraphicsPopContext();
}

- (void)clipPicture{
    
}


@end
