//
//  main.m
//  ZombieDemo
//
//  Created by 杨晴贺 on 9/4/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface HyClass:NSObject
@end

@implementation HyClass
@end

void show_class_info(id obj){
    Class cls = object_getClass(obj);
    //Class cls = [obj class];
    Class scls = class_getSuperclass(cls);
    NSLog(@"%s : %s",class_getName(cls),class_getName(scls));
}

int main(int argc, const char * argv[]) {
    @autoreleasepool{
        HyClass *obj = [[HyClass alloc] init];
        NSLog(@"Before release:");
        show_class_info(obj);
        [obj release] ;
        NSLog(@"After release:");
        show_class_info(obj);
        NSLog(@"%@",obj) ;
    }

    return 0;
}
