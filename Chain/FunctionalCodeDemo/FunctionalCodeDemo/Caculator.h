//
//  Caculator.h
//  FunctionalCodeDemo
//
//  Created by 杨晴贺 on 24/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Caculator : NSObject

@property (nonatomic,assign) int result ;
@property (nonatomic,assign) BOOL isEqual ;

- (instancetype)add:(int(^)(int result))block ;
- (instancetype)equal:(BOOL(^)(int result))block ;

@end
