//
//  ViewController.m
//  NSSessionBackgroudDownDemo
//
//  Created by 杨晴贺 on 9/7/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>{
    NSURLSessionDownloadTask *_downloadTask ;
    NSString *_fileName ;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downloadFile] ;
}

#pragma mark - 取得一个后台会话,保证一个后台会话
- (NSURLSession *)backgroundSession{
    static NSURLSession *session ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.silence.urlsession"] ;
        config.timeoutIntervalForRequest = 5.0 ;  //请求超时时间
        config.discretionary = YES ;  //系统自动选择最佳网路
        config.HTTPMaximumConnectionsPerHost = 5 ;  //限制每次最多链接
        // 创建会话
        session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil] ;  //指定代理
    });
    return session ;
}

#pragma mark - 文件下载
- (void)downloadFile{
    _fileName = @"demo.m" ;
    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.1.208/FileDownload?file=%@",_fileName] ;
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]] ;
    
    // 后台会话
    _downloadTask = [[self backgroundSession]downloadTaskWithRequest:request] ;
    
    [_downloadTask resume] ;
}

#pragma mark - 下载任务代理
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
    NSLog(@"%.2f",(double)totalBytesSent / totalBytesExpectedToSend) ;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"下载完成") ;
    NSError *error ;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] ;
    NSString *savePath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[NSDate date]]] ;
    NSURL *saveUrl = [NSURL fileURLWithPath:savePath] ;
    [[NSFileManager defaultManager] copyItemAtURL:location toURL:saveUrl error:&error] ;
    if(error){
        NSLog(@"出错了%@",error) ;
    }
}

#pragma mark 任务完成,不管下载是否成功
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if(error){
        NSLog(@"出错了%@",error) ;
    }
}


@end
