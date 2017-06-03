//
//  BookProvider.h
//  NSProxyDemo
//
//  Created by 杨晴贺 on 2017/6/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BookProviderProtocol <NSObject>

- (void)purchaseBookWithTitle:(NSString *)bookTitle;

@end

@interface BookProvider : NSObject

@end
