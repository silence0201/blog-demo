//
//  Reader.h
//  InputStreamDemo
//
//  Created by 杨晴贺 on 2017/5/22.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reader : NSObject

- (id)initWithFileAtURL:(NSURL *)fileURL;

- (void)enumerateLinesWithBlock:(void (^)(NSUInteger lineNumber, NSString *line))block
              completionHandler:(void (^)(NSUInteger numberOfLines))completion;

@end
