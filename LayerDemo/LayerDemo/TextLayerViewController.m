//
//  TextLayerViewController.m
//  LayerDemo
//
//  Created by 杨晴贺 on 13/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TextLayerViewController.h"
#include <CoreText/CoreText.h>

@interface TextLayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property (weak, nonatomic) IBOutlet UIView *attibuteLabelView;

@end

@implementation TextLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //create a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.labelView.bounds;
    [self.labelView.layer addSublayer:textLayer];
    
    //set text attributes
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    //choose some text
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
    
    //set layer text
    textLayer.string = text;
    
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    //create a text layer
    CATextLayer *attibuteTextLayer = [CATextLayer layer];
    attibuteTextLayer.frame = self.labelView.bounds;
    attibuteTextLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.attibuteLabelView.layer addSublayer:attibuteTextLayer];
    
    // set text attributes
    attibuteTextLayer.alignmentMode = kCAAlignmentJustified ;
    attibuteTextLayer.wrapped = YES ;
    
    // chose a font
    UIFont *attFont = [UIFont systemFontOfSize:15] ;
    
    // chose some text
    NSString *attitext = @"Lorem ipsum dolor sit amet, consectetur adipiscing  elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar  leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc  elementum, libero ut porttitor dictum, diam odio congue lacus, vel  fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet  lobortis";
    
    //create attributed string
    NSMutableAttributedString *attriString = nil ;
    attriString = [[NSMutableAttributedString alloc]initWithString:attitext] ;
    
    // cover UIFont to a CTFont
    CFStringRef attfontName = (__bridge CFStringRef)attFont.fontName;
    CGFloat attFontSize = attFont.pointSize ;
    CTFontRef attfontRef = CTFontCreateWithName(attfontName, attFontSize, NULL);
    
    // set text attributes
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName: (__bridge id)attfontRef
                              };
     [attriString setAttributes:attribs range:NSMakeRange(0, [text length])];
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName: (__bridge id)attfontRef
                };
    [attriString setAttributes:attribs range:NSMakeRange(6, 5)];
    
    //release the CTFont we created earlier
    CFRelease(attfontRef);
    
    //set layer text
    attibuteTextLayer.string = attriString;
    
}

@end
