
    //
//  RCDownloadTool.m
//  RCHttpClient
//
//  Created by Developer on 16/4/8.
//  Copyright © 2016年 rc.com.ltd. All rights reserved.
//

#import "RCDownloadTool.h"
#import "AFURLSessionManager.h"

@interface RCDownloadTool ()

@property (nonatomic, strong) NSMutableArray * _Nonnull taskQueue;

@property (nonatomic, strong) AFURLSessionManager *manager;

@end

@implementation RCDownloadTool

- (id)init {
    if (self = [super init]) {
        _taskQueue = [NSMutableArray arrayWithCapacity:0];
        NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:defaultConfig];
    }
    return self;
}

- (void)pauseTask:(NSString *)fileName {
    for (NSDictionary * taskInfo in _taskQueue) {
        NSString *file = taskInfo[@"fileName"];
        if ([fileName isEqualToString:file]) {
            NSURLSessionDownloadTask *task = taskInfo[@"task"];
            [task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSError *error = nil;
                NSString *cachePath = [self cachePathWithFile:fileName];
                [fileManager removeItemAtPath:cachePath error:&error];
                NSLog(@"缓存路径: %@",cachePath);
                NSLog(@"清理错误: %@",error);
                [resumeData writeToFile:cachePath atomically:YES];
            }];
            break;
        }
    }
}

- (void)resumeTask:(NSString *)fileName
          progress:(RCDownloadProgress)progress
        Completion:(RCDownloadCompletion)completion {
    for (NSDictionary * taskInfo in _taskQueue) {
        NSString *file = taskInfo[@"fileName"];
        if ([fileName isEqualToString:file]) {
            NSString *downloadPath = [self cachePathWithFile:fileName];
            NSData *resumeData = [NSData dataWithContentsOfFile:downloadPath];
            if (resumeData.length == 0) {
                resumeData = [NSData data];
            }
                //下载任务
            NSURLSessionDownloadTask *resumeTask = [_manager downloadTaskWithResumeData:resumeData  progress:^(NSProgress * _Nonnull downloadProgress) {
                progress(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                completion(response, filePath, error); //下载完成调用的方法
            }];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:taskInfo];
            [dic setObject:resumeTask forKey:@"task"];
            [_taskQueue replaceObjectAtIndex:[_taskQueue indexOfObject:taskInfo] withObject:[dic copy]];
            [resumeTask resume];
            return;
        }
    }
}

- (void)downLoadFromServer:(NSString *)fileUrl fileName:(NSString *)fileName progress:(RCDownloadProgress _Nullable)downProgress completionHandler:(RCDownloadCompletion _Nonnull)completion {
    for (NSDictionary *taskInfo in _taskQueue) {
        NSString *file = taskInfo[@"fileName"];
        if ([file isEqualToString:fileName]) {
            NSURLSessionDownloadTask *task = taskInfo[@"task"];
            if (task.state == NSURLSessionTaskStateCompleted) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"Task Has completed" delegate:nil cancelButtonTitle:@"朕知道了" otherButtonTitles: nil];
                [alert show];
            }
            else if (task.state != NSURLSessionTaskStateRunning) {
                [self resumeTask:fileName progress:^(float progress) {
                    downProgress(progress);
                } Completion:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                    completion(response, filePath, error);
                }];
            }
            NSLog(@"%@ 任务已经存在",fileName);
            return;
        }
    }
    NSURL *url = [NSURL URLWithString:fileUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask * task = [_manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (downProgress) {
            downProgress(1.0 *downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completion(response, filePath, error); //下载完成调用的方法
    }];
    [task resume];
    NSDictionary *taskInfo = @{@"fileName":fileName,
                               @"fileUrl":fileUrl,
                               @"task":task
                               };
    [_taskQueue addObject:taskInfo];
}


/*
- (void)resumeTaskCompletion:(RCDownloadCompletion)completion {
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:defaultConfig];
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *downloadPath = [cacheDirectory stringByAppendingPathComponent:_fileName];
    _cachePath = downloadPath;
    NSData *resumeData = [NSData dataWithContentsOfFile:downloadPath];
    NSLog(@"文件大小%d",resumeData.length);
        //下载任务
    _resumableTask = [manager downloadTaskWithResumeData:resumeData  progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            //下载地址
        NSLog(@"默认下载地址:%@",targetPath);
            //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
            //        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL URLWithString:downloadPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completion(response, filePath, error); //下载完成调用的方法
    }];

    [_resumableTask resume];

}
    // 下载文件
- (void)downLoadFromServer:(NSString *)address fileName:(NSString *)fileName progress:(RCDownloadProgress _Nullable)downProgress completionHandler:(RCDownloadCompletion _Nonnull)completion {
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:defaultConfig];
        //2.确定请求的URL地址
    NSURL *url = [NSURL URLWithString:address];
    _address = address;
    _fileName = fileName;
        //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *downloadPath = [cacheDirectory stringByAppendingPathComponent:fileName];
    _cachePath = downloadPath;
    NSURLSessionDownloadTask * task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (downProgress) {
            downProgress(1.0 *downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL URLWithString:downloadPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completion(response, filePath, error); //下载完成调用的方法
    }];
    [task resume];
}
*/


#pragma mark-
#pragma mark- cache path Helper

- (NSString *)cachePathWithFile:(NSString *)fileName {
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cachePath = [cacheDirectory stringByAppendingPathComponent:fileName];
    return cachePath;
}

@end
