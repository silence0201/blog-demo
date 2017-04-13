//
//  ExceptionHandler.h
//  ExceptionHandlerDemo
//
//  Created by 杨晴贺 on 2017/4/13.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExceptionHandler : NSObject

/*!
 *  异常的处理方法
 *
 *  @param install   是否开启捕获异常
 */
+ (void)installExceptionHandler:(BOOL)install;

@end
