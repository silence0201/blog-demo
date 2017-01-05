//
//  RCHttpClient.m
//  RCHttpClient
//
//  Created by Developer on 16/4/5.
//  Copyright © 2016年 rc.com.ltd. All rights reserved.
//

#import "RCHttpClient.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AFURLSessionManager.h"
#import "NSString+Helper.h"

@interface RCHttpClient ()

@end

@implementation RCHttpClient
{
    NSURLSessionDownloadTask *_resumableTask;
    NSString *_fileName;
    NSString *_address;
}


/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功回调
 *  @param failure 失球失败回调
 *
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(RCRequestSuccess)success failure:(RCRequestFailure)failure {
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self requestWithMethod:@"POST" url:url params:params withCache:NO success:success failure:failure];
}

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 *
 */
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params withCache:(BOOL)isCache success:(RCRequestSuccess)success failure:(RCRequestFailure)failure{
        //如果url有中文等特殊字符需要编码
    url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [url URLEncodedString];

    /**** unused
    if (isCache) {
        NSString *cachePath = [self fullPath:url];
        NSFileManager *fm = [NSFileManager defaultManager];
        if([fm fileExistsAtPath:cachePath]) {
            if([NSFileManager isTimeout:cachePath time:60*60*12] == NO) {
                [self loadFromBackground:cachePath success:success];
                return;
            }
        }
    }
     */
    [self requestWithMethod:@"GET" url:url params:params withCache:isCache success:success failure:failure];
}

+ (void)requestWithMethod:(NSString *)method url:(NSString *)url params:(NSDictionary *)params withCache:(BOOL)isCache success:(RCRequestSuccess)success failure:(RCRequestFailure)failure{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer.timeoutInterval = 20;
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/xml",@"application/json",@"text/plain",@"application/plain",nil];
    if ([method isEqualToString:@"POST"]) {
        [session POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        } progress:^(NSProgress * _Nonnull uploadProgress) {
                //进度
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                success(json);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }
    else {
        [session GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"总大小:%lld-当前:%lld",downloadProgress.totalUnitCount,downloadProgress.completedUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSFileManager *fm = [NSFileManager defaultManager];
            NSString *file =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            file = [file URLEncodedString];
            [fm createFileAtPath:[self fullPath:file] contents:responseObject attributes:nil];
            success(json);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }
}


    //获取已下载的文件大小
- (unsigned long long)fileSizeForPath:(NSString *)path {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

+ (void)urlUploadToServer:(NSString *)address
              fileData:(NSDictionary *)fileData
              progress:(RCProgress)upProgress
            completion:(RCSessionCompletion)completion {

    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:defaultConfiguration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *type = fileData[@"type"];
    if ([type isEqualToString:@"data"]) {
        NSData *data = fileData[@"data"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:address]];
            [manager uploadTaskWithRequest:request fromData:data progress:^(NSProgress * _Nonnull uploadProgress) {
                if (upProgress) {
                    upProgress(1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
                }
            } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                completion(response,responseObject,error);
            }];
    }
    else if ([type isEqualToString:@"path"]) {
        NSString *path = fileData[@"path"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:address]];
        request.HTTPMethod = @"POST";
        NSLog(@"path request: %@ %@", fileURL,request);
        NSURLSessionUploadTask *task = [manager uploadTaskWithRequest:request fromFile:fileURL progress:^(NSProgress * _Nonnull uploadProgress) {
            if (upProgress) {
                upProgress(1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
            }
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            completion(response,responseObject,error);
        }];
        [task resume];
    }
}

+ (void)uploadToServer:(NSString *)address
            parameters:(NSDictionary *)params
              fileData:(NSDictionary *)fileData
              progress:(RCProgress)upProgress
               success:(RCRequestSuccess)success
               failure:(RCRequestFailure)failure {
        //1:创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/xml",@"application/json",@"text/plain",@"application/plain",nil];
    [manager POST:address parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *name = fileData[@"name"];
        NSString *fileName = fileData[@"fileName"];
        NSString *mimeType = fileData[@"mimeType"];
        NSString *type = fileData[@"type"];
        if ([type isEqualToString:@"data"]) {
            NSData *data = fileData[@"data"];
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
        }
        else if ([type isEqualToString:@"path"]) {
            NSString *path = fileData[@"path"];
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:path] name:name fileName:fileName mimeType:@"application/octet-stream" error:nil];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (upProgress) {
            upProgress(1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(json);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)getCurrentNetworkStatus:(CurrentStatus)currentStatus {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        currentStatus(status);
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (void)loadFromBackground:(NSString *)cachesPath success:(RCRequestSuccess)success {
    if (success) {
        id json = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:cachesPath] options:NSJSONReadingMutableLeaves error:nil];
        success(json);
    }
    else {
        //缓存获取数据失败
    }
}

#pragma mark - 删除内存
+ (void)cleanupCache:(NSString *)url {
    url = [url URLEncodedString];
    NSString *asiCachePath = [self fullPath:[url MD5Hash]];
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:asiCachePath]){
        [fm removeItemAtPath:asiCachePath error:nil];
    }
}


    //获得指定文件的全路径
+ (NSString *)fullPath:(NSString *)fileName {

    NSString *homePath = NSHomeDirectory();
    homePath = [homePath stringByAppendingPathComponent:@"Library/Caches"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:homePath]){
        if(fileName && [fileName length] > 0) {
            homePath = [homePath stringByAppendingPathComponent:[fileName MD5Hash]];
        }
    }
    else {
            //创建文件夹
        BOOL success = [fm createDirectoryAtPath:homePath withIntermediateDirectories:YES attributes:nil error:nil];
        if(success){
        }
        
    }
    return homePath;
}

@end
