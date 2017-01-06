//
//  SILuaViewController.m
//  LuaViewDemo
//
//  Created by 杨晴贺 on 05/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "SILuaViewController.h"
#import "SIButton.h"
#import "SIError.h"
#import "SILoading.h"
#import "SIImage.h"

@interface SILuaViewController ()

@end

@implementation SILuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;
}

- (void)dealloc{
    [self.lv releaseLuaView] ;
}

- (void)willCreateLuaView{
    [super willCreateLuaView];
    while (self.view.subviews.count) {
        UIView* child = self.view.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)didCreateLuaView:(LView *)view{
    // 注册 基础控件
    self.lv[@"Image"] = [SIImage class];
    self.lv[@"Button"] = [SIButton class];
    // 注册 用户面板类型
    self.lv[@"CustomError"] = [SIError class];
    self.lv[@"CustomLoading"] = [SILoading class];
    // 注册 外部对象.
    self.lv[@"viewController"] = self;
}

-(void) openUrl:(NSString*)actionUrl{
    LVLog(@"%@",actionUrl);
}

-(void) gotoHistory{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)externalApiDemo:(NSString *)str number:(NSInteger)number{
    NSLog(@"%@--%ld",str,number) ;
}
- (void)pushToOthers{
    Class clazz = NSClassFromString(@"OtherViewController") ;
    UIViewController *vc = [[clazz alloc]init] ;
    [self.navigationController pushViewController:vc animated:YES] ;
}

- (void)testJson:(NSDictionary *)dic{
    NSLog(@"JSON:%@",dic); 
}



@end
