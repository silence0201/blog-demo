//
//  ViewController.m
//  LuaScriptCoreDemo
//
//  Created by 杨晴贺 on 11/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "ViewController.h"
#import "LuaScriptCore.h"
#import "CustomModule.h"
#import "CustomObject.h"

@interface ViewController ()

// lua上下文
@property (nonatomic,strong) LSCContext *context ;

// 是否注册过方法
@property (nonatomic,assign) BOOL hasRegMethod ;

// 是否注册过模块
@property (nonatomic,assign) BOOL hasRegModule ;

// 是否注册过类
@property (nonatomic,assign) BOOL hasRegClass ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化上下文
    self.context = [[LSCContext alloc]init] ;
    
    // 捕获异常
    [self.context onException:^(NSString *message) {
        NSLog(@"error = %@",message) ;
    }] ;
}

/// 解析脚本按钮点击事件
- (IBAction)evalScriptButtonClicked:(id)sender {
    LSCValue *returnValue = [self.context evalScriptFromString:@"print(10);return 'Hello World';"] ;
    NSLog(@"%@",[returnValue toString]) ;
}

- (IBAction)regMethodClicked:(id)sender {
    if (!self.hasRegMethod) {
        // 注册方法的方法
        [self.context registerMethodWithName:@"getDeviceInfo" block:^LSCValue *(NSArray<LSCValue *> *arguments) {
            NSLog(@"传入的参数%@",arguments) ;
            NSMutableDictionary *info =
            [NSMutableDictionary dictionary];
            [info setObject:[UIDevice currentDevice].name
                     forKey:@"deviceName"];
            [info setObject:[UIDevice currentDevice].model
                     forKey:@"deviceModel"];
            [info setObject:[UIDevice currentDevice].systemName
                     forKey:@"systemName"];
            [info setObject:[UIDevice currentDevice].systemVersion
                     forKey:@"systemVersion"];
            
            return [LSCValue dictionaryValue:info] ;
        }] ;
    }
    
    // 调用脚本
    [self.context evalScriptFromFile:@"main.lua"] ;
}

- (IBAction)callLuaMethodClicked:(id)sender {
    // 加载lua脚本
    [self.context evalScriptFromFile:@"todo.lua"] ;
    
    // 调用lua方法
    LSCValue *value = [self.context callMethodWithName:@"add"
                                             arguments:@[[LSCValue integerValue:24],[LSCValue integerValue:1000]]] ;
    NSLog(@"Result = %@",[value toNumber]) ;
}

- (IBAction)registerModuleClicked:(id)sender {
    if (!self.hasRegModule) {
        self.hasRegModule = YES ;
        [self.context registerModuleWithClass:[CustomModule class]] ;
    }
    
    [self.context evalScriptFromString:@"CustomModule.testLog('Hello Lua Module!');"] ;
}

- (IBAction)registerClassClicked:(id)sender {
    if (!self.hasRegClass) {
        self.hasRegClass = YES ;
        [self.context registerModuleWithClass:[CustomObject class]] ;
    }
    
    [self.context evalScriptFromFile:@"test.lua"] ;
}


@end
