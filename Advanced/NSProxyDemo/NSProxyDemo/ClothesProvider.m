//
//  ClothesProvider.m
//  NSProxyDemo
//
//  Created by 杨晴贺 on 2017/6/3.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ClothesProvider.h"

@interface ClothesProvider ()<ClothesProviderProtocol>

@end

@implementation ClothesProvider

- (void)purchaseClothesWithSize:(ClothesSize )size{
    NSString *sizeStr;
    switch (size) {
        case ClothesSizeLarge:
            sizeStr = @"large size";
            break;
        case ClothesSizeMedium:
            sizeStr = @"medium size";
            break;
        case ClothesSizeSmall:
            sizeStr = @"small size";
            break;
        default:
            break;
    }
    NSLog(@"You've bought some clothes of %@",sizeStr);
}


@end
