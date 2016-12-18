//
//  ColorViewController.h
//  UIPopoverControllerDemo
//
//  Created by 杨晴贺 on 18/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectColorBlock)(UIColor *color);

@interface ColorViewController : UIViewController

/** 选择颜色的回调block */
@property (nonatomic, copy) SelectColorBlock selectColorBlock;

@end
