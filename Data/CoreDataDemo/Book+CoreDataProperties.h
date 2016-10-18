//
//  Book+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by 杨晴贺 on 16/7/20.
//  Copyright © 2016年 caigee. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface Book (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *publicHouse;
@property (nullable, nonatomic, retain) NSManagedObject *author;

@end

NS_ASSUME_NONNULL_END
