//
//  main.m
//  privateProtocolTest
//
//  Created by 杨晴贺 on 9/17/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
#import "Sleep.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [[Person alloc]init] ;
        
        // 运行结果1,说明协议被隐藏了,但是仍有这个方法
        NSLog(@"%d",[person respondsToSelector:@selector(sleep)]) ;
        // 编译失败,说明方法没有被公开,不能随意调用
        // [person sleep] ;
        
        // 可以利用一下方法进行调用
        id<Sleep> sl = person ; 
        [sl sleep] ;
        
        // 继承
        Student *student = [[Student alloc]init] ;
        // 运行结果为1,说明私有的协议也是被继承了
        NSLog(@"%d",[student respondsToSelector:@selector(sleep)]) ;
        // 同理这里会编译失败
        // [student sleep] ;
        
        // 可以利用一下方法调用
        id<Sleep> st = student ;
        [st sleep] ;
    }
    return 0;
}
