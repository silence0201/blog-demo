//
//  TestClass.m
//  ProtrolDemo
//
//  Created by 杨晴贺 on 8/14/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass

// 在协议中只生成了生命.没有产生具体的set和get方法,因此需要进行手动产生对应的方法
// @synthesize的语义是如果你没有手动实现setter方法和getter方法，那么编译器会自动为你加上这两个方法
// @dynamic告诉编译器：属性的setter与getter方法由用户自己实现，不自动生成（当然对于readonly的属性只需提供getter即可）

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
