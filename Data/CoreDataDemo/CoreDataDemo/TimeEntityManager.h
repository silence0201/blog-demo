//
//  TimeEntityManager.h
//  CoreDataDemo
//
//  Created by 杨晴贺 on 16/7/7.
//  Copyright © 2016年 caigee. All rights reserved.
//

#import "CoreDataManager.h"
#import "TimeEntity.h"

@interface TimeEntityManager : CoreDataManager

-(NSArray *)timeEntities;
-(NSArray *)timeEntitiesWithTitle:(NSString *)title;
-(TimeEntity *)makeEntityWithTime:(NSString *)time;
-(BOOL)removeTimeEnities:(NSArray *)timeEArray;
-(BOOL)removeALLTimeEnities;


@end
