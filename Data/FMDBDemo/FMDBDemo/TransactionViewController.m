//
//  TransactionViewController.m
//  FMDBDemo
//
//  Created by 杨晴贺 on 8/10/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TransactionViewController.h"
#import "FMDB.h"

@interface TransactionViewController ()

@property (nonatomic,strong)FMDatabaseQueue *queue ;

@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"demo2.db"] ;
    _queue = [FMDatabaseQueue databaseQueueWithPath:filePath] ;
    [_queue inDatabase:^(FMDatabase *db) {
        //创建数据表
        BOOL flag = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS T_USER (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, age INTEGER);"];
        if (flag) {
            NSLog(@"表创建成功");
        } else {
            NSLog(@"表创建失败");
        }
    }] ;
    
    
}

// 插入数据
- (IBAction)insert {
        [_queue inDatabase:^(FMDatabase *db) {
            BOOL flag = [db executeUpdate:@"INSERT INTO T_USER (name,age) VALUES (?,?)",@"Silence",@18];
            if (flag) {
                NSLog(@"数据添加成功");
            } else {
                NSLog(@"数据添加失败");
            }
        }];
}

// 删除数据
- (IBAction)delete {
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:@"DELETE FROM T_USER;"];
        if (flag) {
            NSLog(@"数据删除成功");
        } else {
            NSLog(@"数据删除失败");
        }
    }];
}

// 修改数据
- (IBAction)update {
    [_queue inDatabase:^(FMDatabase *db) {
        // 开启事务
        [db beginTransaction] ;
        BOOL flag = [db executeUpdate:@"UPDATE T_USER SET age = ?",@20];
        if (flag) {
            NSLog(@"数据删除成功");
        } else {
            NSLog(@"数据删除失败");
            [db rollback] ;
        }
        [db commit] ;
    }];
}

// 查看数据
- (IBAction)select {
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:@"SELECT * FROM T_USER"];
        
        while ([result next]) {
            NSString *name = [result stringForColumn:@"name"];
            NSString *age = [result stringForColumn:@"age"];
            NSLog(@"%@---%@",name,age);
        }
    }];
}

// 删除数据表
- (IBAction)drop {
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:@"DROP TABLE IF EXISTS T_USER"];
        if (flag) {
            NSLog(@"数据表删除成功");
        } else {
            NSLog(@"数据表删除失败");
        }
    }];
}



@end
