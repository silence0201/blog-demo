//
//  Description.h
//  CoreData-Demo
//
//  Created by 杨晴贺 on 2017/5/23.
//  Copyright © 2017年 刘小壮. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
 *  对应Department类的depDescription属性
 */
@interface Description : NSObject <NSCoding>
@property (nonatomic, copy  ) NSString  *leaderName;
@property (nonatomic, assign) NSInteger employeeCount;
@end
