//
//  Employee+CoreDataProperties.h
//  CoreData-Demo
//
//  Created by 杨晴贺 on 2017/5/23.
//  Copyright © 2017年 刘小壮. All rights reserved.
//

#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *brithday;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Department *department;

@end

NS_ASSUME_NONNULL_END
