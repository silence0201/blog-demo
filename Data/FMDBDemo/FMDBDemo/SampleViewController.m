//
//  SampleViewController.m
//  FMDBDemo
//
//  Created by 杨晴贺 on 8/10/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "SampleViewController.h"
#import "FMDB.h"

@interface SampleViewController ()

@property (nonatomic,strong) FMDatabase *db ; //数据库对象

@end

@implementation SampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化数据库对象
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] ;
    NSString *filePath = [path stringByAppendingPathComponent:@"demo.db" ] ;
    _db = [FMDatabase databaseWithPath:filePath] ;
    
    if([_db open]){
        NSLog(@"打开成功") ;
    }else{
        NSLog(@"打开失败") ;
    }
    
    // 创建数据表
    BOOL flag = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS T_USER(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,age INTEGET);"] ;
    if (flag) {
        NSLog(@"创建数据表成功") ;
    }else{
        NSLog(@"创建数据表失败") ;
    }
}

// 插入数据
- (IBAction)insert {
    BOOL flag = [_db executeUpdate:@"INSERT INTO T_USER(name,age) VALUES (?,?)",@"Slience",@18] ;
    if (flag) {
        NSLog(@"插入数据成功") ;
    }else{
        NSLog(@"插入数据失败") ;
    }
    
}

// 删除数据
- (IBAction)delete {
    BOOL flag = [_db executeUpdate:@"DELETE FROM T_USER;"] ;
    if (flag) {
        NSLog(@"删除数据成功") ;
    }else{
        NSLog(@"删除数据失败") ;
    }
}

// 更新数据
- (IBAction)update {
    BOOL flag = [_db executeUpdate:@"UPDATE T_USER SET age = ?",@20] ;
    if (flag) {
        NSLog(@"更新数据成功") ;
    }else{
        NSLog(@"更新数据失败") ;
    }
}

// 查询数据
- (IBAction)select {
    FMResultSet *result = [_db executeQuery:@"SELECT * FROM T_USER"] ;
    while ([result next]) {
        NSString *name = [result stringForColumnIndex:1] ;
        NSString *age = [result stringForColumnIndex:2] ;
        NSLog(@"%@----%@",name,age) ;
    }
}

// 删除数据表
- (IBAction)drop {
    BOOL flag = [_db executeQuery:@"DROP TABLE IF EXISTS T_USER"] ;
    if (flag) {
        NSLog(@"数据表删除成功") ;
    }else{
        NSLog(@"数据表删除失败") ;
    }
}



@end
