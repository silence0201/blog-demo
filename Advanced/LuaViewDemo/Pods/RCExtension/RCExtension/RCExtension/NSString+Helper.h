///
//  HttpRequest.h
//  AutoHome
//
//  Created by Aries on 14-2-10.
//  Copyright (c) 2014年 Aries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

/**
 *  截断收尾空白字符
 *
 *  @return 截断结果
 */
- (NSString *)trimString;

/**
 *  为指定文件名添加沙盒文档路径
 *
 *  @return 添加沙盒文档路径的完整路径字符串
 */
- (NSString *)appendToDocumentDir;

/**
 *  为指定文件名添加沙盒文档路径
 *
 *  @return 添加沙盒文档路径的完整路径字符串
 */
- (NSURL *)appendToDocumentURL;

/**
 *  对指定字符串进行BASE64编码
 *
 *  @return BASE64编码后的字符串
 */
- (NSString *)base64EncodedString;

/**
 *  对指定BASE64编码的字符串进行解码
 *
 *  @return 解码后的字符串
 */
- (NSString *)base64DecodeString;

/**
 *  在字符串末尾添加日期及时间
 *
 *  @return 添加日期及时间之后的字符串
 */
- (NSString *)appendDateTime;

- (NSString *)MD5Hash;

- (NSString *) URLEncodedString;
- (NSString*) URLDecodedString;
- (NSString *) utf8ToUnicode:(NSString *)string;
- (NSString *) unicodeToUtf8:(NSString *)string;

@end
