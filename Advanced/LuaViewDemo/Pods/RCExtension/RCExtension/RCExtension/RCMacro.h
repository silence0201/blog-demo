//
//  RCMacro.h
//  RCKit
//
//  Created by Developer on 16/4/5.
//  Copyright © 2016年 rc.com.ltd. All rights reserved.
//

#ifndef RCMacro_h
#define RCMacro_h


/*******  打印   ********/
#ifdef DEBUG
#    define DLog(...) NSLog(__VA_ARGS__)
#else
#    define DLog(...)
#endif

/*******  Plist 单例  ********/
#define Plist_Handler  [NSUserDefaults standardUserDefaults]


/*******  屏幕尺寸   ********/
#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds
    // 屏幕宽度
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
    // 屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
    // 系统版本
#define SYSTEM_VERSION  [UIDevice currentDevice].systemVersion.floatValue


/*******  颜色   ********/
#define RCColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/*******  字体   ********/
    // 标题字体
#define kTitleFont  [UIFont boldSystemFontOfSize:20]
    //  快速常规体
#define kFont(fontSize) [UIFont systemFontOfSize:fontSize]
    //  快速粗体
#define kBoldFont(fontSize) [UIFont boldSystemFontOfSize:fontSize]


/***** 机型 *****/
    // 4s 以下屏幕
#define k4SPhone (kScreenHeight <= 480)
    // 5/5s 屏幕
#define k568Phone (kScreenHeight > 480 && kScreenHeight <= 568)
    // 6及以上屏幕
#define k6Phone (kScreenHeight > 568)

#endif /* RCMacro_h */
