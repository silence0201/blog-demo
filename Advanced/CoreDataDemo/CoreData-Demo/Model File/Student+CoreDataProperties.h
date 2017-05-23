//
//  Student+CoreDataProperties.h
//  CoreData-Demo
//
//  Created by 杨晴贺 on 2017/5/23.
//  Copyright © 2017年 刘小壮. All rights reserved.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) Teacher *teacher;

@end

NS_ASSUME_NONNULL_END
