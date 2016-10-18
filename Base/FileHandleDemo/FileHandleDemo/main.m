//
//  main.m
//  FileHandleDemo
//
//  Created by 杨晴贺 on 8/14/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *path = NSHomeDirectory() ;
        NSString *fileName = [path stringByAppendingPathComponent:@"file"] ;
        
        NSLog(@"%@",fileName) ;
        
        // 创建句柄
        NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:fileName] ;
        
        // 向句柄中添加数据
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"] ;
        NSData *data = [NSData dataWithContentsOfURL:url] ;
        
        // 将数据写入文件,定位到文件尾
        [fh seekToEndOfFile] ;
        
        // 写入文件
        [fh writeData:data] ;
        
        // 可以定位到任何位置
        [fh seekToFileOffset:100000] ;
        
        // 在写一次
        [fh writeData:data] ;
        
        // 清空源文件数据
//        [fh truncateFileAtOffset:0] ;
        
        //每次写入数据会继续上次的写的内容 每次打开文件都会从头开始写
        
    }
    return 0;
}
