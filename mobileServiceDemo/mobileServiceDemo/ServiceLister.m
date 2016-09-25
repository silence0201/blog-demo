//
//  ServiceLister.m
//  mobileServiceDemo
//
//  Created by 杨晴贺 on 25/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ServiceLister.h"
#import "GCDAsyncSocket.h"

@interface ServiceLister()<GCDAsyncSocketDelegate>

@property (nonatomic,strong) GCDAsyncSocket *serverSocket ;
@property (nonatomic,strong) NSMutableArray *clientSockets ;  // 客户端所有socket对象
@end

// 利用telnet进行链接  telnet 127.0.0.1 10123
@implementation ServiceLister

- (void)start{
    // 创建一个socket对象
    
    // 服务端的socker对象,有没有客户端请求链接
    GCDAsyncSocket *serverSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0) ] ;
    
    // 绑定端口
    NSError *error = nil;
    [serverSocket acceptOnPort:10123 error:&error] ;
    
    // 开启监听--> 在上面绑定端口时已经开始监听,这样这个服务就启动了
    if(!error){
        // 服务开启成功
        NSLog(@"服务开启成功") ;
    }else{
        NSLog(@"服务开启失败") ;
    }
    
    self.serverSocket = serverSocket ;
}

#pragma mark - 有客户端的sock连接到服务器
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    // sock 服务端  newSocket 客户端
    NSLog(@"%@====%@",sock,newSocket) ;
    
    // 保存客户端的socket
    [self.clientSockets addObject:newSocket] ;
    
    // 提供服务
    NSMutableString *serviceStr = [NSMutableString string] ;
    [serviceStr appendString:@"欢迎使用在线客服,请输入下面的数字选择服务:\n"] ;
    [serviceStr appendString:@"[1] 在线充值\n"] ;
    [serviceStr appendString:@"[2] 在线投诉\n"] ;
    [serviceStr appendString:@"[3] 优惠信息\n"] ;
    [serviceStr appendString:@"[4] 特殊服务\n"] ;
    [serviceStr appendString:@"[5] 退出\n"] ;
    [newSocket writeData:[serviceStr dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0] ;
    
    // 监听客户端有没有数据上传
    // timeout -1 代表不超时
    // tag  标志作用
    [newSocket readDataWithTimeout:-1 tag:0] ;
}

#pragma mark - 请求客户端请求的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    // sock 客户端
    NSLog(@"读取数据%@",sock) ;
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    
    NSLog(@"接受到客户端上传的数据:%@",str) ;
    
    // 字符串转数字
    NSString *response = nil;
    NSInteger choic = [str integerValue] ;
    switch (choic) {
        case 1:
            response = @"充值服务不可用.....\n" ;
            break;
        case 2:
            response = @"投诉服务不可用.....\n" ;
            break ;
        case 3:
            response = @"没有优惠信息......\n" ;
            break ;
        case 4:
            response = @"没有特殊服务.....\n" ;
            break ;
        case 5:
            response = @"退出成功\n" ;
            break ;
        default:
            response = @"别瞎输入,输入错误....\n" ;
            break;
    }
    
    // 处理请求,把数据返回给客户端
    [sock writeData:[response dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0] ;
    
    // 退出
    if(choic == 4){
        // 移除客户端
        [self.clientSockets removeObject:sock] ;
    }
    
    // 每次读完数据后都要调用一次监听数据的方法
    [sock readDataWithTimeout:-1 tag:0] ;
}

#pragma mark - Lazy Load
- (NSMutableArray *)clientSockets{
    if(_clientSockets == nil){
        _clientSockets = [NSMutableArray array] ;
    }
    return _clientSockets ;
}
@end
