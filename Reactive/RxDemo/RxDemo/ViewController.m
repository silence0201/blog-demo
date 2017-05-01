//
//  ViewController.m
//  RxDemo
//
//  Created by 杨晴贺 on 2017/4/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@import ReactiveObjC ;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic,strong) Person *person ;

@property (nonatomic,strong) RACDelegateProxy *proxy ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self notificationDemo] ;
    [self delegateDemo] ;
    [self buttonDemo] ;
    [self textFileCombinationDemo] ;
    [self textFieldDemo] ;
    [self KVODemo] ;
    [self liftSelectorDemo] ;
}

-(Person *)person {
    if (!_person) {
        _person = [[Person alloc]init] ;
    }
    return _person ;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.person.name = [NSString stringWithFormat:@"zhang %d",arc4random_uniform(100)];
}

#pragma mark -- 通知
/// 验证此函数：点击textFile时，系统键盘会发送通知，打印出通知的内容
- (void)notificationDemo {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] subscribeNext:^(NSNotification * _Nullable notification) {
        NSLog(@"Notification:%@",notification) ;
    }] ;
}

#pragma mark -- 代理方法
/// 验证此函：nameText的输入字符时，输入回撤或者点击键盘的回车键使passWordText变为第一响应者（即输入光标移动到passWordText处）
- (void)delegateDemo {
    @weakify(self)
    // 定义代理
    self.proxy = [[RACDelegateProxy alloc]initWithProtocol:@protocol(UITextFieldDelegate)] ;
    // 代理去注册文本框的监听方法
    [[self.proxy rac_signalForSelector:@selector(textFieldShouldReturn:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        if(self.nameText.hasText) {
            [self.passWordText becomeFirstResponder];
        }
    }] ;
    self.nameText.delegate = (id<UITextFieldDelegate>)self.proxy ;
}

#pragma mark -- 按钮监听
/// 验证此函数：当loginButton可以点击时，点击button输出person的属性，实现监控的效果
- (void)buttonDemo {
    @weakify(self)
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
          subscribeNext:^(__kindof UIControl * _Nullable x) {
              @strongify(self)
              NSLog(@"Name: %@ --- PasswWord:%@",self.person.name,self.person.password) ;
    }] ;
}

#pragma mark -- 文本信号组合
/// 为了验证此函数，增加了一个passwordText和一个Button，监测nameText和passwordText根据状态是否enabled
- (void)textFileCombinationDemo {
    @weakify(self)
    RACSignal *combineSignal = [RACSignal combineLatest:@[self.nameText.rac_textSignal,self.passWordText.rac_textSignal]] ;
    [combineSignal subscribeNext:^(RACTuple *x) {
        @strongify(self)
        NSString *name = x.first ;
        NSString *password = x.second ;
        if (name.length > 0 && password.length > 0) {
            self.loginBtn.enabled = YES;
            self.person.name = name;
            self.person.password = password;
        } else  {
            self.loginBtn.enabled = NO;
        }
    }] ;
}

#pragma mark -- 文本框输入事件监听
/// 为了测试此函数，增加了一个nameText；监听文本框的输入内容，并设置为self.person.name
- (void)textFieldDemo {
     @weakify(self)
    [self.nameText.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        NSLog(@"%@",x) ;
        self.person.name = x ;
    }] ;
}

#pragma mark -- KVO 监听
/// 为了测试此函数，增加了一个Person类 && 一个Label；点击屏幕则会等改Lable的值
- (void)KVODemo {
    @weakify(self)
    [RACObserve(self.person, name) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.nameLabel.text = x ;
    }] ;
    
//    RAC(self.nameLabel,text) = RACObserve(self.person, name) ;
}

#pragma mark - RACSubjectAnd RACRepalySubject
- (void)RACSubjectAndRACReplaySubject
{
    //    RACSubject使用步骤
    /**
     1、创建信号 【RACSubject subject】，跟RACSignal不一样，创建信号时没有block。
     2、订阅信号 -（RACDisposable *）subscribeNext:(void(^)(id x)nextBlock)
     3、发送信号 sengNext:(id Value)
     
     // RACSubject : 底层实现跟RACSignal不一样
     1、调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
     2、调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock
     */
    
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    
    //订阅信号
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用
        NSLog(@"第一个订阅者：%@",x);
    }];
    [subject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者:%@",x);
    }];
    
    //    3、发送信号
    [subject sendNext:@1];
    [subject sendNext:@2];
    
    
    
    //    RACRepalySubject使用步骤
    /**
     
     1、创建信号 [RACReplaySubject subject] ,跟RACSignal不一样，创建信号时没有block
     2、可以先发送信号，再订阅信号，RACSubject不可以！！！
     *订阅信号 -(RACDisposable)subscribeNext:(void(^)(id x))nextBlock
     *发送信号 sendNext:(id)value
     
     RACReplaySubject：底层实现和RACSubject不一样
     1、调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock
     2、调用subscribeNext订阅信号，遍历所有保存的值，一个一个调用订阅者的nextBlock
     
     如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，再订阅信号
     也就是先保存值，再订阅值
     
     */
    
    
    //    1、创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject replaySubjectWithCapacity:2];
    
    //2、发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3、订阅信号
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者收到的数据%@",x);
    }];
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者收到的数据%@",x);
    }];
    
}

#pragma mark -- liftSelector
- (void)liftSelectorDemo {
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"发送请求1"];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号一被销毁了") ;
        }];
    }];
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"发送请求2"];
        });
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号二被销毁了") ;
        }];
    }];

    // 使用注意：几个信号，参数一的方法就必须有几个参数，每个参数对应信号发出的数据
    [self rac_liftSelector:@selector(wtkUpdateWithDic1:withDic2:) withSignalsFromArray:@[request1,request2]];
}

- (void)wtkUpdateWithDic1:(id )dic1 withDic2:(id )dic2{
    NSLog(@"1--%@\n 2---%@",dic1,dic2);
}

@end
