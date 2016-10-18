//
//  ServiceLister.m
//  GroupChat
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
    NSLog(@"serverSock: %@",sock) ;
    NSLog(@"clientSock: %@,host:%@ port:%d",newSocket,newSocket.connectedHost,newSocket.connectedPort) ;
    
    // 保存客户端的socket
    [self.clientSockets addObject:newSocket] ;
    
    
    // 监听客户端有没有数据上传
    // timeout -1 代表不超时
    // tag  标志作用
    [newSocket readDataWithTimeout:-1 tag:0] ;
    
    
    NSLog(@"当前有%ld个客户端链接到服务器",self.clientSockets.count) ;
}

#pragma mark - 请求客户端请求的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    // sock 客户端
    NSLog(@"读取数据%@",sock) ;
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    
    NSLog(@"接受到客户端上传的数据:%@",str) ;
    
    // 把当前的数据转发给其他的客户端:
    for(GCDAsyncSocket *socket in self.clientSockets){
        if (socket != sock) {
            NSString *string = [NSString stringWithFormat:@"%@:%d,%@",sock.connectedHost,sock.connectedPort,str] ;
            [socket writeData:[string dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0] ;
        }
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
