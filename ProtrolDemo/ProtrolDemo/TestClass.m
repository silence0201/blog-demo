//
//  TestClass.m
//  ProtrolDemo
//
//  Created by 杨晴贺 on 8/14/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass

// 在协议总定义属性不会生成对应的成员变量,只会生成对应的get和set方法,成员属性需要手动进行生成

//@synthesize name ;
//@synthesize age ;
@synthesize name = _name ;
@synthesize age = _age ;

- (void)print{
    NSLog(@"%@---%@",self.name,self.age) ;
//    NSLog(@"%@---%@",name,age) ;
    NSLog(@"%@---%@",_name,_age) ;
    
}

- (void)test{
    self.name = @"小明" ;
    self.age = @"12" ;
    [self print] ;
}

@end
