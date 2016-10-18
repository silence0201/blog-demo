//
//  CaculatorMaker.h
//  ChainCodeDemo
//
//  Created by 杨晴贺 on 24/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorMaker : NSObject

@property (nonatomic,assign) int result ;

- (CaculatorMaker *(^)(int num))add ;

- (CaculatorMaker *(^)(int num))multy ;

@end
