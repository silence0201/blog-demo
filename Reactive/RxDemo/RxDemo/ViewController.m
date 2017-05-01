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

@implementation ViewController{
    RACCommand *_command ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self notificationDemo] ;
    [self delegateDemo] ;
    [self buttonDemo] ;
    [self textFileCombinationDemo] ;
    [self textFieldDemo] ;
    [self KVODemo] ;
    [self liftSelectorDemo] ;
    [self RACSubjectAndRACReplaySubjectDemo] ;
    [self RACSequenceDemo];
    [self RACCommandDemo] ;
    [self RACMulticastConnectionDemo] ;
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
- (void)RACSubjectAndRACReplaySubjectDemo {
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
    
    //3、发送信号
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
    //1、创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject replaySubjectWithCapacity:2];
    
    //2、发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    //3、订阅信号
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

#pragma mark -- RACSequenceDemo
- (void)RACSequenceDemo {
    // 遍历数组
    NSArray *array = @[@1,@2,@3];
    //把数组转换成集合RACSequence，array.rac_seuqence
    //把集合RACSequence转换RACSignal信号类，array.rac_sequence.signal
    //订阅信号，激活信号，会自动把集合中的所有值，遍历出来
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x) ;
    }] ;
    
    // 遍历字典，遍历出来的键值会包装成RACTuple（元祖对象）
    NSDictionary *dic = @{@"name":@"wangtongke",@"age":@18};
    [dic.rac_sequence.signal subscribeNext:^(RACTuple  *x) {
        RACTupleUnpack(NSString *key,NSString *value) = x ;
        
        //以上 相当于一下写法
        //NSString *key1 = x[0];
        //NSString *value1 = x[1];
        
        NSLog(@"%@  %@\n",key,value);
    }] ;
}

#pragma mark -- RACComand
- (void)RACCommandDemo {
    
     //1、创建命令 initWithSignalblock:(RACSignal * (^)(id input))signalBlock
     // 2、在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
     // 3、执行命令 -(RACSignal *)execute:(id)input
     
     // 注意事项
     // 1、signalBlock必须要返回一个signal，不能返回nil，
     // 2、如果不想要传递信号,直接创建空的信号返回[RACSignal empty]；
     // 3、RACCommand，如果数据传递完毕，必须调用[subscriber sendCompleted],这时命令才会执行完毕，否则永远处于执行中.
     // 4、RACComand需要被强引用，否则接手不到RACCommand中的信号，因此，RACCommand中的信号是延迟发送的。
     
     
     // 设计思想  ： 内部signalBlock为什么要返回一直信号，这个信号有什么用
     // 1、在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
     // 2、当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了
     
     
     // 如何拿到RACCommand中返回信号发出的数据
     // 1、RACCommand有个执行信号源executionSignal,这个signal of signal（信号的信号）,意思是发出的数据是信号，不是普通的类型
     // 2、订阅executionSignal就能拿到RACCommand中返回的信号，然后订阅signalblock返回的信号。
     
     
     // 监听当前命令是否正在执行executing
     
     // 使用场景  按钮点击，网络请求
    
    // 创建命令
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"执行命令");
        NSLog(@"input---%@",input);
        // 创建空信号，必须返回信号
        // return [RACSignal empty];
        
        // 创建信号,用来传递数据
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"请求数据"] ;
            //  注意：数据传递完，最好调用sendCompleted，这时命令才执行完毕
            [subscriber sendCompleted] ;
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"销毁信号") ;
            }] ;
        }] ;
    }] ;
    
    // 强引用命令，不然会自动销毁，接受不到数据
    _command = command ;
    
    // 订阅信号
    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x) ;
    }] ;
    
    // 另一种写法
    [command.executionSignals subscribeNext:^(id x) {
        [x subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }];
    
    // 监听命令是否执行完毕，默认会来一次，可以直接跳过，skip表示跳过第一次信号
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在执行") ;
        }else{
            NSLog(@"执行完成") ;
        }
    }] ;
    
    // 执行命令
    [_command execute:@1] ;
}

#pragma mark - RACMulticastConnection
- (void)RACMulticastConnectionDemo {
    /**
     RACMulticastConnection使用步骤
     
     ****   1、创建信号 +(RACSignal)createSignal
     ****   2、创建连接  RACMulticastConnection *connect = [signal publish];
     ****   3、订阅信号，注意：订阅的不再是之前的信号，而是连接的信号[connect.signal subscribeNext];
     ****   4、连接 [connect connect];
     
     
     RACMulticastConnection底层原理
     
     // 1.创建connect，connect.sourceSignal -> RACSignal(原始信号)  connect.signal -> RACSubject
     // 2.订阅connect.signal，会调用RACSubject的subscribeNext，创建订阅者，而且把订阅者保存起来，不会执行block。
     // 3.[connect connect]内部会订阅RACSignal(原始信号)，并且订阅者是RACSubject
     // 3.1.订阅原始信号，就会调用原始信号中的didSubscribe
     // 3.2 didSubscribe，拿到订阅者调用sendNext，其实是调用RACSubject的sendNext
     // 4.RACSubject的sendNext,会遍历RACSubject所有订阅者发送信号。
     // 4.1 因为刚刚第二步，都是在订阅RACSubject，因此会拿到第二步所有的订阅者，调用他们的nextBlock
     
     
     
     需求 ： 假设子啊一个信号中发送请求，每次订阅一次都会发送请求，这样就会导致多次请求。
     解决  使用RACMulticastConnection。
     
     
     */
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"Send") ;
        [subscriber sendNext:@"Sine"] ;
        return nil ;
    }] ;
    
    // 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接受数据--%@",x) ;
    }] ;
    
    // 订阅两次信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接受数据2--%@",x) ;
    }] ;
    
    //  会执行两次发送请求。也就是每订阅一次  就会发送一次请求
    
    //  ********** 1、创建信号
    
    RACSignal *signal2  = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送请求2");
        [subscriber sendNext:@1];
        return nil;
    }];
    // 创建连接
    RACMulticastConnection *connect = [signal2 publish];
    
    //订阅信号
    // 注意：订阅信号也不能激活信号，只是保存订阅者到数据，必须通过连接，当调用连接，就会一次清调用所有订阅者的sendNext；
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者一信号");
    }];
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者二信号");
    }];
    
    //连接
    [connect connect];

    
}


@end
