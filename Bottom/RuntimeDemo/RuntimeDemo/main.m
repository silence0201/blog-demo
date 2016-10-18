//
//  main.m
//  RuntimeDemo
//
//  Created by 杨晴贺 on 8/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import <objc/runtime.h>

/**
 *  分割线
 */
void separate(){
    printf("============================\n") ;
}


/**
 *  从这个类中获取自定义成员属性列表
 */
void getCustomMemberOfTHeClassProperties(){
    Person *person = [Person sharedInstance] ;
    unsigned int outCount ;
    // 传入类和可写入的数量值返回值是数组
    // class_copyPropertyList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    objc_property_t *properties = class_copyPropertyList([person class], &outCount) ;
    
    // 循环遍历这个数,取出数组的每个属性,打印出名字
    for(int i = 0 ;i<outCount;i++){
        objc_property_t property = properties[i] ;
        NSLog(@"所有属性:%@",[NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding]);
    }
    // 释放这个数组
    free(properties) ;
}

/**
 *  获取成员属性
 */
void getCustomMemberOfTheClassProperty(){
    Person *person = [Person sharedInstance] ;
    // 传入类和属性名
    // class_getProperty(<#__unsafe_unretained Class cls#>, <#const char *name#>)
    objc_property_t property = class_getProperty([person class], "customImage") ;
    NSLog(@"单一属性:%@",[NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding]) ;
    
}
/**
 *  给类添加方法
 */
void addMethodForClass(){
    Person *person = [Person sharedInstance];
    //传入需要添加的类,类声明,类实现,以及方法typeEncoding
    class_addMethod([person class], @selector(getCustomMemberOfTheClassProperty), (IMP)getCustomMemberOfTheClassProperty, "v@:");
    [person getCustomMemberOfTheClassProperty];
}

/**
 *  获取方法列表
 *
 *  @param count 方法列表的数目
 *
 *  @return 方法列表
 */
Method *getMethodListFormClass(int *count){
    Person *person = [Person sharedInstance];
    unsigned int outCount = 0;
    Method *methodList = class_copyMethodList([person class], &outCount);
    for (int index = 0; index<outCount; index++) {
        Method m = methodList[index];
        NSLog(@"方法名:%@",[NSString stringWithCString:sel_getName(method_getName(m)) encoding:NSUTF8StringEncoding]);
    }
    *count = outCount;
    free(methodList);
    return methodList;
}

/**
 *  替换方法的实现
 */
void replaceMethodImplementation(){
    // 传入类 方法声明  方法实现  方法实现的typeEncoding
    class_replaceMethod([[Person sharedInstance] class], @selector(getMethodFormClass), (IMP)getMethodListFormClass, "v@:");
}

/**
 *  获取方法的实现,并且利用IMP直接进行调用
 */
void getMethodImplementation(){
    Person *person = [Person sharedInstance] ;
    // 获取方法实现,返回值是一个IMP类型
    IMP helloWorld = class_getMethodImplementation([person class], @selector(helloworld2));
    // 这个方法实现没有参数.所以可以直接调用
    helloWorld();
}

/**
 *  相应方法
 */
void respondsToSelector(){
    Person *person = [Person sharedInstance] ;
    if (class_respondsToSelector([person class], @selector(respondsTest))) {
        NSLog(@"实现了");
    }else{
        NSLog(@"未响应");
    }
}

/**
 *  添加协议
 */
void addProtocolForClass(){
    Person *person = [Person sharedInstance] ;
    Protocol *protocol;
    class_addProtocol([person class], protocol);
}

/**
 *  添加属性
 */
void addPropertyForClass(){
    Person *person = [Person sharedInstance] ;
    objc_property_attribute_t attribute1;
    attribute1.name = "name1";
    attribute1.value = "1";
    objc_property_attribute_t attribute2;
    attribute2.name = "name2";
    attribute2.value = "2";
    objc_property_attribute_t attributes[] = {attribute1,attribute2};
    class_addProperty([person class], "name", attributes, 2);
}

/**
 *  获得属性列表
 */
void getProtocolList(){
    Person *person = [Person sharedInstance] ;
    unsigned int outCount = 0;
    Protocol * __unsafe_unretained * proList = class_copyProtocolList([person class], &outCount);
    for (int index = 0; index<outCount; index++) {
        Protocol *pro = proList[index];
        NSLog(@"协议名称:%s",protocol_getName(pro));
    }
}

/**
 *  获取类版本
 */
void getVersion(){
    Person *person = [Person sharedInstance] ;
    NSLog(@"类版本:%d",class_getVersion([person class]));
}

/**
 *  设置类版本
 */
void setVersion(){
    Person *person = [Person sharedInstance] ;
    class_setVersion([person class], 1);
}

/**
 *  返回值的类型
 */
void copyReturnType(){
    int outCount = 0;
    Method *methodList = getMethodListFormClass(&outCount);
    for (int index = 0; index<outCount; index ++) {
        Method m = methodList[index];
        NSLog(@"返回返回参数类型:%s",method_copyReturnType(m));
    }
}

/**
 *  参数类型
 */
void copyArgumentType(){
    Person *person = [Person sharedInstance] ;
    Method m = class_getInstanceMethod([person class],@selector(helloword2)) ;
    NSLog(@"%s", method_copyArgumentType(m, 0));
}

/**
 *  获取内部参数值
 */
void getImageName(){
    Person *person = [Person sharedInstance] ;
    NSLog(@"%s",class_getImageName([person class]));
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [Person sharedInstance] ;
        separate() ;
        getCustomMemberOfTHeClassProperties() ;
        separate() ;
        getCustomMemberOfTheClassProperty() ;
        separate() ;
        // [person getCustomMemberOfTheClassProperty] ;  放在这里调用会报错
        addMethodForClass() ;
        [person getCustomMemberOfTheClassProperty] ;   //添加完后,可以进行调用
        separate() ;
        [person run] ;
        separate() ;
        // [person sleep] ;  没有找到合适的转发者,因此会崩溃
        [person walk] ;
        
        
        
    }
    return 0;
}
