//
//  Person.m
//  RuntimeDemo
//
//  Created by 杨晴贺 on 8/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "Person.h"
#import "Dog.h"
#import <objc/runtime.h>

@interface Person ()

@property (nonatomic,strong) NSImage *customImage ;

@end

@implementation Person

static char imgch_key ;

- (instancetype)init{
    if (self = [super init]) {
        [self addMethod] ;
    }
    return self ;
}

- (NSImage *)customImage{
    return objc_getAssociatedObject(self, &imgch_key) ;
}

- (void)setCustomImage{
    //    typedef OBJC_ENUM(uintptr_t, objc_AssociationPolicy) {
    //        OBJC_ASSOCIATION_ASSIGN = 0,           /**< Specifies a weak reference to the associated object. */
    //        OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, /**< Specifies a strong reference to the associated object.
    //                                                *   The association is not made atomically. */
    //        OBJC_ASSOCIATION_COPY_NONATOMIC = 3,   /**< Specifies that the associated object is copied.
    //                                                *   The association is not made atomically. */
    //        OBJC_ASSOCIATION_RETAIN = 01401,       /**< Specifies a strong reference to the associated object.
    //                                                *   The association is made atomically. */
    //        OBJC_ASSOCIATION_COPY = 01403          /**< Specifies that the associated object is copied.
    //                                                *   The association is made atomically. */
    //    };
    objc_setAssociatedObject(self, &imgch_key, _customImage, OBJC_ASSOCIATION_RETAIN) ;
}

void helloworld(){
    NSLog(@"helloWorld");
    
}

/**
 *  为类添加方法
 */
- (void)addMethod{
    // IMP 对应关键字 implemention
    class_addMethod([Person class], @selector(helloword2), (IMP)helloworld, "v@:") ;
    //    v 该方法的返回值为void
    //    24 说明整个方法占用24个字节
    //    @0表示offset0的位置是self   不变
    //    :8 表示offset8的位置是SEL   不变
    //    @16表示offset16的位置为oc指针类型参数1 oc指针类型都是@,其余的基本类型为 i,c等等
    
    [self helloword2] ;
}

/**
 *  从类里获取一个方法的名字
 */
- (void)getMethodFormClass{
    Method m = class_getInstanceMethod([self class], @selector(addMethod)) ;
    
    NSLog(@"方法名:%@",[NSString stringWithCString:sel_getName(method_getName(m)) encoding:NSUTF8StringEncoding]);

}

+ (instancetype)sharedInstance{
    static Person *person = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        person = [[Person alloc]init] ;
    });
    return person ;
}

/**
 *  消息转发第一步,先从这个方法中查看能否获取到对象方法实现,能的话就返回yes,否则为no
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(run)) {
        class_addMethod(self, sel, (IMP)helloworld, "v@:") ;
        return YES ;
    }else if(sel == @selector(sleep)){
        return NO ;
    }
    return [super resolveInstanceMethod:sel] ;
}

/**
 *  消息转发第二步,返回一个方法实现的类来进行调动改方法,aSelector是传入的调用哪个方法
 */
- (id)forwardingTargetForSelector{
    return [[Dog alloc]init] ;
}

/**
 *  消息转发第三步,先生成方法签名,然后进行方法调用
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(walk)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

/**
 *  方法调用,这是最后一步,消息转发越往后花费的代价就越大
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL aseleter = [anInvocation selector] ;
    Dog *dog = [[Dog alloc]init] ;
    if ([dog respondsToSelector:aseleter]) {
        [anInvocation invokeWithTarget:dog] ;
    }
}

@end
