//
//  ViewController.m
//  RACUSeFrmo
//
//  Created by 杨晴贺 on 25/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "GrayView.h"
#import "ReactiveCocoa.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet GrayView *grayView;
@property (nonatomic,assign) NSInteger age ;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (nonatomic, strong) RACSignal *signal;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark - 用RAC替代代理
    // RAC:判断下一个方法有没有调用,如果调用了就会自动发送一个信号给你
    // 只要self调用viewDidLoad就会转换成一个信号
    // 监听_redView有没有调用btnClick:,如果调用了就会转换成信号
    [[_grayView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
        NSLog(@"%@",x) ;
        NSLog(@"通知控制器点击了灰色View内部的按钮") ;
    }] ;
    
#pragma mark - KVO
    // 监听哪个对象的属性改变
    // 方法调用者:就是被监听的对象
    // KeyPath:监听的属性
    
    // 把监听到内容转换成信号
    [[self rac_valuesForKeyPath:@"age" observer:nil]subscribeNext:^(id x) {
        // block:只要属性改变就会调用,并且把改变的值传递给你
        NSLog(@"改变为了%@",x) ;
    }] ;
    
#pragma mark - 监听事件
    // 只要产生UIControlEventTouchUpInside就会转换成信号
    [[_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self btnClick:x] ;
    }] ;
    
#pragma mark - 监听通知
    // 只要发送这个通知,就会转换成一个信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"%@",x) ;
        NSLog(@"弹出了键盘") ;
    }] ;

#pragma mark - 监听文本框文字改变
    [_input.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"%@",x) ;
        NSLog(@"文本框发生了改变") ;
    }] ;
    
#pragma mark - 判断是否全部完成
    // 创建热门商品的信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 处理信号
        NSLog(@"请求热门商品信号") ;
        
        // 发送信号
        [subscriber sendNext:@"热门商品信息"] ;
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"注销") ;
        }] ;
    }] ;
    
    // 创建最新商品的信号
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 处理信号
        NSLog(@"请求最新商品信号") ;
        
        // 发送信号
        [subscriber sendNext:@"热门最新信息"] ;
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"注销") ;
        }] ;
    }] ;
    
    // RAC:就可以判断两个信号有没有都发出内容
    // SignalsFromArray:监听哪些信号的发出
    // 当signals数组中的所有信号都发送sendNext就会触发方法调用者(self)的selector
    // 注意:selector方法的参数不能乱写,有几个信号就对应几个参数
    // 不需要主动订阅signalA,signalB,方法内部会自动订阅
    [self rac_liftSelector:@selector(updateUIWithHot:new:) withSignalsFromArray:@[signalA,signalB]] ;
 
    
#pragma mark - 利用宏绑定信号
    // RAC:把一个对象的某个属性绑定一个信号,只要发出信号,就会把信号的内容给对象的属性赋值
    // 给label的text属性绑定了文本框改变的信号
    RAC(self.textLabel,text) = _input.rac_textSignal ;
    
#pragma mark - 利用宏绑定KVO信号
    // KVO
    // RACObserveL:快速的监听某个对象的某个属性改变
    // 返回的是一个信号,对象的某个属性改变的信号
    [RACObserve(self,age) subscribeNext:^(id x) {
        NSLog(@"age改变为了:%@",x) ;
    }] ;
    
#pragma mark - 利用宏避免循环引用
    // 把self转换成一个弱指针
    @weakify(self);
    
    // 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self);
        NSLog(@"%@",self.view);
        return nil;
    }];
    self.signal = signal ;
    
#pragma mark - 利用宏包装元祖
    // 快速包装一个元组
    // 把包装的类型放在宏的参数里面,就会自动包装
    RACTuple *tuple = RACTuplePack(@1,@3);
    NSLog(@"%@",tuple) ;
    
    // 快速的解析一个元组对象
    // 等会的右边表示解析哪个元组
    // 宏的参数:表示解析成什么
    RACTupleUnpack_(NSNumber *num1,NSNumber *num2) = tuple;
    NSLog(@"%@ %@",num1,num2);
}

#pragma mark - Action
- (void)updateUIWithHot:(NSString *)hot new:(NSString *)new{
    NSLog(@"hot:%@===new:%@",hot,new) ;
    NSLog(@"更新UI");
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.age ++ ;
    [self.view endEditing:YES] ;
}

- (void)btnClick:(UIButton *)btn{
    NSLog(@"%@",btn) ;
    NSLog(@"View的按钮被点击") ;
}


@end
