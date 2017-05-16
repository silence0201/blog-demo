//
//  ViewController.m
//  KVOControllerDemo
//
//  Created by 杨晴贺 on 2017/5/16.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import <KVOController/KVOController.h>

@interface Person : NSObject

@property (nonatomic,strong) NSString *name ;
@property (nonatomic,assign) NSUInteger age ;

@end

@implementation Person
@end

@interface ViewController ()

@property (nonatomic,strong) Person *person ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.person = [[Person alloc]init] ;
    
    [self.KVOController observe:self.person keyPath:@"name" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"%@",change) ;
    }] ;
    
    [self.KVOController observe:self.person keyPath:@"age" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"%@",change);
    }] ;
    
    self.person.name = @"New Name" ;
    self.person.age = 12 ;
}



@end
