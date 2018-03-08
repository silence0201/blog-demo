//
//  KVOTestViewController.m
//  Crash
//
//  Created by Silence on 2018/3/8.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "KVOTestViewController.h"
#import "XXShieldSDK.h"

@interface Student : NSObject

@property (nonatomic, copy) NSString   *name;

@end

@implementation Student

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@",object);
}

- (void)dealloc {
    NSLog(@"student dealloced");
}

@end

@interface KVOTestViewController ()

@property (nonatomic,strong) NSString *test ;

@property (nonatomic,strong) Student *obsever;

@end

@implementation KVOTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _obsever = [Student new];
}
- (IBAction)test1:(id)sender {
    Student *s = [[Student alloc] init];
    s.name = @"Test";
    
    [s addObserver:self
        forKeyPath:@"name"
           options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
           context:nil];
    
    // 延时1000ms后改变stu的name属性值
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        s.name = @"Silence";
    });
    
}

// 使用局部遍历监听,局部变量提前释放导致赋值失效
- (IBAction)test2:(id)sender {
    self.test = @"Hello";
    [self addObserver:[Student new] forKeyPath:@"test" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
    // 这里赋值会失败,局部变量地址成为野指针
    //[self willChangeValueForKey:@"test"]
    self.test = @"World";
}

- (IBAction)test3:(id)sender {
    self.test = @"Hello";
    [self addObserver:self.obsever forKeyPath:@"test" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
    self.test = @"World";
    
    [self removeObserver:self.obsever forKeyPath:@"test"];
    self.test = @"One";
    // Cannot remove an observer  for the key path ,because it is not registered as an observer.
    [self removeObserver:self.obsever forKeyPath:@"test"];
}

- (IBAction)test4:(id)sender {
    [self addObserver:self.obsever forKeyPath:@"view" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:@"Test1"];
    
    // remove Context不一致,最好不要添加 Context
    [self removeObserver:self.obsever forKeyPath:@"view" context:@"Test2"];
}

// KVOTest1:屏蔽下面:message was received but not handled
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
   NSLog(@"%@",object);
}



@end
