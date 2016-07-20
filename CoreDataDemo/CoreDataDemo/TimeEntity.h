//
//  TimeEntity.h
//  CoreDataDemo
//
//  Created by 杨晴贺 on 16/7/7.
//  Copyright © 2016年 caigee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TimeEntity : NSManagedObject

@property (nonatomic, retain) NSString * timeCreated;
@property (nonatomic, retain) NSNumber * number;

@end
