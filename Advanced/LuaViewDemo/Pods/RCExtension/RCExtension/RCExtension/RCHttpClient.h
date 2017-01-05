//
//  RCHttpClient.h
//  RCHttpClient
//
//  Created by Developer on 16/4/5.
//  Copyright © 2016年 rc.com.ltd. All rights reserved.
//  Http 请求

#import <Foundation/Foundation.h>

/**
 *  进度回调
 *
 *  @param progress 进度 0-1
 */
typedef void (^RCProgress)(float progress);

/**
 * 请求成功之后的回调
 *
 * @prama json 后台返回的数据类型
 */
typedef void(^RCRequestSuccess)(id _Nonnull result);

/**
 * 请求失败之后的回调
 *
 * @prama error 错误信息
 */
typedef void(^RCRequestFailure)(NSError * _Nonnull error);

/**
 *  请求完成回调
 *
 *  @param response 响应
 *  @param filePath 存储路径
 *  @param error    错误
 */
typedef void(^RCRequestCompletion)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error);

/**
 *  URLSession 回调
 *
 *  @param response       响应
 *  @param responseObject 结果
 *  @param error          错误信息
 */
typedef void (^RCSessionCompletion)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error);

/**
 *  当前网络状态回调
 *
 *  @param currentStatus 当前网络状态
 */
typedef void(^CurrentStatus)(NSInteger currentStatus);


@interface RCHttpClient : NSObject

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功回调
 *  @param failure 失球失败回调
 *
 */
+ (void)postWithUrl:(NSString *_Nonnull)url params:(NSDictionary * _Nullable)params success:(RCRequestSuccess _Nonnull)success failure:(RCRequestFailure _Nonnull)failure;


/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 *
 */
+ (void)getWithUrl:(NSString * _Nonnull)url params:(NSDictionary * _Nullable)params withCache:(BOOL)isCache success:(RCRequestSuccess _Nonnull)success failure:(RCRequestFailure _Nonnull)failure;


/**
 *  上传文件
 *
 *  @param address  服务器地址
 *  @param params   请求参数
 *  @param fileData 上传的文件的参数  {mimeType:?,fileName:header中, type:data/path, name:"文件名字", data:"如果 type为 data", path:"如果 type 为 path"}
 *  @param success  上传成功的回调
 *  @param failure  失败的回调
 */
+ (void)uploadToServer:(NSString * _Nonnull)address
            parameters:(NSDictionary * _Nullable)params
              fileData:(NSDictionary * _Nonnull)fileData
              progress:(RCProgress _Nullable)upProgress
               success:(RCRequestSuccess _Nonnull)success
               failure:(RCRequestFailure _Nonnull)failure;

/**
 *  AFURLSession 上传
 *
 *  @param address    服务器地址
 *  @param fileData   上传的文件的信息
 *  @param upProgress 上传进度
 *  @param completion 完成后回调
 */
+ (void)urlUploadToServer:(nonnull NSString *)address
                 fileData:(nonnull NSDictionary *)fileData
                 progress:(nullable RCProgress)upProgress
               completion:(nonnull RCSessionCompletion)completion;


+ (void)getCurrentNetworkStatus:(CurrentStatus _Nonnull)currentStatus;

@end
