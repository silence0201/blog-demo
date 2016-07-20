//
//  CoreDataManager.h
//  CoreDataDemo
//
//  Created by 杨晴贺 on 16/7/7.
//  Copyright © 2016年 caigee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


+(id)sharedCoreDataManager;
- (BOOL)saveContext;

// Context Operations
- (void)undo;
- (void)redo;
- (void)rollback;
- (void)reset;

@end
