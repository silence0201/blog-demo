//
//  ViewController.m
//  HppleDemo
//
//  Created by 杨晴贺 on 10/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"

@interface ViewController ()

@property (nonatomic,strong) NSMutableArray *avatarMutableArray ;
@property (nonatomic,strong) NSMutableDictionary *allDataMutableDict ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"hpple" ofType:@"html"] ;
    NSData *htmlData = [NSData dataWithContentsOfFile:path] ;
    
    
    TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:htmlData];
    
#pragma mark 每页主题
    NSArray *itemArray = [xpathParser searchWithXPathQuery:@"//div[@class = 'cell item']"];
    NSLog(@"itemArray:%@",itemArray) ;
    //通过for in 在itemArray数组中 循环查找子节点
    for (TFHppleElement *hppleElement in itemArray) {
        
#pragma mark 子节点头像
        
        NSArray *IMGElementsArr = [hppleElement searchWithXPathQuery:@"//img"];
        for (TFHppleElement *tempAElement in IMGElementsArr) {
            NSString *imgStr = [tempAElement objectForKey:@"src"];
            NSString *subStr = [@"http:" stringByAppendingString:imgStr];
            NSLog(@"%@",subStr) ;
        }
        
#pragma mark 子节点标题/链接
        
        NSArray *TitleElementArr = [hppleElement searchWithXPathQuery:@"//span[@class='item_title']"];
        for (TFHppleElement *tempAElement in TitleElementArr) {
            //获得标题
            NSString *titleStr =  [tempAElement content];
            NSLog(@"titleStr:%@",titleStr) ;
            
            //1.获得子节点（正文连接节点） 2.获得节点属性值
            NSArray * arr = [tempAElement children];
            TFHppleElement *href = arr.firstObject;
            NSString * titleHrefStr = [href objectForKey:@"href"];
            NSLog(@"titleHrefStr:%@",titleHrefStr) ;
        }
        
        
#pragma mark 子节点fade
        //简化写法 简化3步
        NSArray *nodeElementArr = [hppleElement searchWithXPathQuery:@"//a[@class='node']"];
        
        NSArray *fadeElementArr = [hppleElement searchWithXPathQuery:@"//span[@class = 'small fade']"];
        NSArray *subArray = [ [fadeElementArr.firstObject content] componentsSeparatedByString:@"  •  "];
        
        NSLog(@"subArray:%@",subArray) ;
        
        
#pragma mark 子节点回复数
        NSArray * repeatElementArr = [hppleElement searchWithXPathQuery:@"//a[@class = 'count_livid']"];
        NSLog(@"repeatElement:%@", [repeatElementArr.firstObject content]) ;
    }
}


@end
