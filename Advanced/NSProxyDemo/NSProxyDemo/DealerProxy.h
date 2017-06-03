//
//  DealerProxy.h
//  NSProxyDemo
//
//  Created by 杨晴贺 on 2017/6/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookProvider.h"
#import "ClothesProvider.h"

@interface DealerProxy : NSProxy <BookProviderProtocol,ClothesProviderProtocol>

+ (instancetype)dealerProxy ;

@end
