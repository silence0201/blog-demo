//
//  NSObject+Caculator.h
//  ChainCodeDemo
//
//  Created by 杨晴贺 on 24/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaculatorMaker.h"

@interface NSObject (Caculator)

+ (int)makeCaculator:(void(^)(CaculatorMaker *make))block ;

@end
