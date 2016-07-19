//
//  ViewController.m
//  Archiving
//
//  Created by 杨晴贺 on 16/7/16.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <sqlite3.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self getDirectionaryDemo] ;
//    [self plistDemo] ;
//    [self userDefaultDemo] ;
//    [self simpleArchiver] ;
//    [self personArchiverDemo] ;
//    [self personTwoArchiverDeom] ;
    [self sqliteDemo] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取目录
- (void)getDirectionaryDemo{
    //获取沙盒根目录
    NSString *home = NSHomeDirectory() ;
    NSLog(@"沙盒根目录是:%@",home) ;
    
    //获取沙盒的Document目录
    NSString *document = [home stringByAppendingPathComponent:@"Documents"] ;
    NSLog(@"沙盒的为文档目录是：%@",document) ;
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) ;
    document = [array firstObject] ;
    NSLog(@"文档目录为：%@",document) ;
    
    //tmp目录
    NSString *tmp = NSTemporaryDirectory() ;
    NSLog(@"tmp文件目录：%@",tmp) ;
    
    //Library/Caches目录
    NSString *ca = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] ;
    NSLog(@"Caches目录为:%@",ca) ;
}

//属性列表plist
- (void)plistDemo{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary] ;
    [dic setObject:@"小王" forKey:@"name"] ;
    [dic setObject:@"10086" forKey:@"phone"] ;
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] ;
    NSString *path = [document stringByAppendingPathComponent:@"dic.plist"] ;
    //进行归档
    [dic writeToFile:path atomically:YES] ;
    NSLog(@"%@",@"归档成功") ;
    
    //进行读档
    NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithContentsOfFile:path] ;
    NSLog(@"%@",@"读档成功") ;
    NSLog(@"原字典为：%@,%p",dic,dic);
    NSLog(@"读取的字典为：%@,%p",dics,dic) ;

}

//用户偏好设置
-(void)userDefaultDemo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults] ;
    [defaults setObject:@"小明" forKey:@"name"] ;
    [defaults synchronize] ;
    NSLog(@"%@",@"归档成功") ;
    
    //读取
    NSString *name = [defaults stringForKey:@"name"] ;
    NSLog(@"%@",name) ;
    NSLog(@"%@",@"读档成功") ;
}

//NSKeyedArchiver && NSKeyedUnarchiver
- (void)simpleArchiver{
    NSArray *array = @[@"1",@"2",@"3"] ;
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"demo.archiver"] ;
    //对数组进行归档处理
    [NSKeyedArchiver archiveRootObject:array toFile:path] ;
    NSLog(@"保存成功") ;
    //对数组进行解档
    NSArray *a = [NSKeyedUnarchiver unarchiveObjectWithFile:path] ;
    NSLog(@"解档的值为：%@",a) ;
}

// 对一个对象进行归档
- (void)personArchiverDemo{
    Person *p = [[Person alloc]init] ;
    p.name = @"小明" ;
    p.age = 12 ;
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"demo.archiver"] ;
    //对对象归档
    [NSKeyedArchiver archiveRootObject:p toFile:path] ;
    NSLog(@"%@",@"归档成功") ;
    Person *p2 = [NSKeyedUnarchiver unarchiveObjectWithFile:path] ;
    NSLog(@"p1:%@--%p",p,p) ;
    NSLog(@"p2:%@--%p",p2,p2) ;
    
}

//对两个对象进行归档
- (void)personTwoArchiverDeom{
    Person *p1 = [[Person alloc]init] ;
    Person *p2 = [[Person alloc]init] ;
    
    p1.name = @"小白" ;
    p1.age = 12 ;
    p2.name = @"小巴" ;
    p2.age = 13 ;
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"demo.archiver"] ;
    
    //创建一个可变的数据区
    NSMutableData *data = [NSMutableData data] ;
    //将数据去链接到一个NSKeyedArchiver对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data] ;
    //开始进行归档
    [archiver encodeObject:p1 forKey:@"p1"] ;
    [archiver encodeObject:p2 forKey:@"p2"] ;
    //存档完毕
    [archiver finishEncoding] ;
    //归档保存到文件
    [data writeToFile:path atomically:YES] ;
    
    //读取
    NSData *dd = [NSData dataWithContentsOfFile:path] ;
    //解析为解档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:dd] ;
    //恢复对象
    Person *pp1 = [unarchiver decodeObjectForKey:@"p1"] ;
    Person *pp2 = [unarchiver decodeObjectForKey:@"p2"] ;
    
    NSLog(@"p1:%@---pp1:%@",p1,pp1) ;
    NSLog(@"p2:%@---pp2:%@",p2,pp2) ;
}

//初始化打开数据库
sqlite3 *db ;
-(void)initDB{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"test.sqlite" ofType:nil] ;
    if (sqlite3_open([path UTF8String], &db) == SQLITE_OK) {
        NSLog(@"数据库打开成功") ;
    }else{
        sqlite3_close(db) ;
        NSLog(@"数据库打开失败") ;
    }
}
//查询数据
- (void)operateDB{
    const char *sql = "select * from person" ;
    //创建sql语句对象
    sqlite3_stmt *sm ;
    int result = sqlite3_prepare_v2(db, sql, -1, &sm, NULL) ;
    if (result == SQLITE_OK) {  //是否准备结束
        while(sqlite3_step(sm) == SQLITE_ROW){  //开始遍历查询结果
            NSLog(@"name %s,age:%d",sqlite3_column_text(sm, 1),sqlite3_column_int(sm, 2)) ;
        }
    }
}


//使用sqlite进行数据存储
- (void)sqliteDemo{
    [self initDB];
    [self operateDB] ;
    
}

@end
