//
//  ViewController.m
//  UIPopoverControllerDemo
//
//  Created by 杨晴贺 on 18/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import "OneViewController.h"
#import "ColorViewController.h"
#import "TestViewController.h"

@interface ViewController ()<UIPopoverControllerDelegate>

/** 选择颜色的Popover */
@property (nonatomic, strong) UIPopoverController *colorPopover;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)menuAction:(id)sender {
    // 创建内容控制器
    MenuViewController *menuVc = [MenuViewController new] ;
    
    // 创建UIPopoverController
    UIPopoverController *menuPopover = [[UIPopoverController alloc]initWithContentViewController:menuVc] ;
    
    // 设置内容控制器
    // [menuPopover setContentViewController:menuVc];
    
    // 设置尺寸
    // [menuPopover setPopoverContentSize:CGSizeMake(100, 44 * 3)];
    
    // 设置显示的位置
    [menuPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES] ;
    
}

- (IBAction)controllerAction:(id)sender {
    OneViewController *oneVc = [OneViewController new] ;
    UINavigationController *oneNav = [[UINavigationController alloc]initWithRootViewController:oneVc] ;
    
    // 创建UIPopoverController,并且设置内容控制器
    UIPopoverController *controllerPopover = [[UIPopoverController alloc]initWithContentViewController:oneNav] ;
    
    [controllerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES] ;
}

- (IBAction)selectedColorAction:(UIButton *)sender {
    [self.colorPopover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)ios8Action:(UIButton *)sender {
    
    // 创建控制器
    TestViewController *testVc = [TestViewController new] ;
    // 设置弹出样式
    testVc.modalPresentationStyle = UIModalPresentationPopover ;
    // 设置弹出的位置
    testVc.popoverPresentationController.sourceView = sender;
    testVc.popoverPresentationController.sourceRect = sender.bounds;
    
    [self presentViewController:testVc animated:YES completion:nil] ;
}


- (UIPopoverController *)colorPopover{
    if (_colorPopover == nil) {
        // 1.创建内容控制器
        ColorViewController *colorVc = [[ColorViewController alloc] init];
        
        // 2.创建UIPopoverController,并且指定内容控制器
        self.colorPopover = [[UIPopoverController alloc] initWithContentViewController:colorVc];
        
        __weak UIPopoverController *colorPover = _colorPopover;
        __weak UIView *weakView = self.view;
        colorVc.selectColorBlock = ^(UIColor *color) {
            weakView.backgroundColor = color;
            [colorPover dismissPopoverAnimated:YES];
        };
    }
    return _colorPopover;
}

@end
