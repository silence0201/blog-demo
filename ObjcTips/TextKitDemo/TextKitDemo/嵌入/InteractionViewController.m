//
//  InteractionViewController.m
//  TextKitDemo
//
//  Created by 杨晴贺 on 2017/5/23.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "InteractionViewController.h"
#import "CircleView.h"

@interface InteractionViewController () 
@property (weak, nonatomic) IBOutlet CircleView *circleView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation InteractionViewController{
    CGPoint _panOffset;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load text
    [self.textView.textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"lorem" withExtension:@"txt"] usedEncoding:NULL error:NULL]];
    // Set up circle pan
    [self.circleView addGestureRecognizer: [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(circlePan:)]];
    [self updateExclusionPaths];
    
    // Enable hyphenation
    self.textView.layoutManager.hyphenationFactor = 1.0;
}

#pragma mark - Exclusion

- (void)circlePan:(UIPanGestureRecognizer *)pan
{
    // Capute offset in view on begin
    if (pan.state == UIGestureRecognizerStateBegan)
        _panOffset = [pan locationInView: self.circleView];
    
    // Update view location
    CGPoint location = [pan locationInView: self.view];
    CGPoint circleCenter = self.circleView.center;
    
    circleCenter.x = location.x - _panOffset.x + self.circleView.frame.size.width / 2;
    circleCenter.y = location.y - _panOffset.y + self.circleView.frame.size.width / 2;
    self.circleView.center = circleCenter;
    
    // Update exclusion path
    [self updateExclusionPaths];
}

- (void)updateExclusionPaths
{
    CGRect ovalFrame = [self.textView convertRect:self.circleView.bounds fromView:self.circleView];
    
    // Since text container does not know about the inset, we must shift the frame to container coordinates
    ovalFrame.origin.x -= self.textView.textContainerInset.left;
    ovalFrame.origin.y -= self.textView.textContainerInset.top;
    
    // Simply set the exclusion path
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect: ovalFrame];
    self.textView.textContainer.exclusionPaths = @[ovalPath];
    
}

@end
