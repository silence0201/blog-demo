//
//  AppDelegate.m
//  baiduMapDemo
//
//  Created by 杨晴贺 on 27/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "AppDelegate.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

@interface AppDelegate ()<BMKGeneralDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _mapManager = [[BMKMapManager alloc]init] ;
    
    BOOL ret = [_mapManager start:@"GqXpbTlDrShZHtaO5jzwop19cXBy5muI" generalDelegate:self] ;
    if(!ret){
        NSLog(@"启动失败") ;
    }
    return YES;
}

- (void)onGetNetworkState:(int)iError{
    if (iError) {
        NSLog(@"联网失败:%d",iError) ;
    }else{
        NSLog(@"联网成功") ;
    }
}

- (void)onGetPermissionState:(int)iError{
    if(iError){
        NSLog(@"授权失败:%d",iError);
    }else{
        NSLog(@"授权成功") ;
    }
}


@end
