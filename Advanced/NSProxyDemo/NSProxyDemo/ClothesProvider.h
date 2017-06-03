//
//  ClothesProvider.h
//  NSProxyDemo
//
//  Created by 杨晴贺 on 2017/6/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ClothesSize) {
    ClothesSizeSmall = 0,
    ClothesSizeMedium,
    ClothesSizeLarge
};

@protocol ClothesProviderProtocol <NSObject>

- (void)purchaseClothesWithSize:(ClothesSize)size;

@end

@interface ClothesProvider : NSObject

@end
