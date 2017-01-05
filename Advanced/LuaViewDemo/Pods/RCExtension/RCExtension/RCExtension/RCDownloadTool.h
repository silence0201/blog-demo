//
//  RCDownloadTool.h
//  RCHttpClient
//
//  Created by Developer on 16/4/8.
//  Copyright © 2016年 rc.com.ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  文件下载进度
 *
 *  @param progress 进度 0.0~1.0
 */
typedef void (^RCDownloadProgress)(float progress);

/**
 *  下载完成回调
 *
 *  @param response 响应
 *  @param filePath 文件路径
 *  @param error    下载错误
 */
typedef void (^RCDownloadCompletion)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error);

@interface RCDownloadTool : NSObject

/**
 *  任务队列
 */
@property (nonatomic, strong, readonly) NSMutableArray * _Nonnull taskQueue;

/**
 *  下载文件
 *
 *  @param address    地址
 *  @param params     请求参数
 *  @param completion 完成回调
 */
- (void)downLoadFromServer:(NSString * _Nonnull)fileUrl
                  fileName:(NSString * _Nonnull)fileName
                  progress:(RCDownloadProgress _Nullable)downProgress
         completionHandler:(RCDownloadCompletion _Nonnull)completion;

/**
 *  暂停下载任务
 */
- (void)pauseTask:(nonnull NSString *)fileUrl;

/**
 *  继续下载任务
 *
 *  @param completion  完成回调
 */
- (void)resumeTask:(nonnull NSString*)fileUrl progress:(nonnull RCDownloadProgress)progress Completion:(nullable RCDownloadCompletion)completion;


@end
