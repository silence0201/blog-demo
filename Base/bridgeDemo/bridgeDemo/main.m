//
//  main.m
//  bridgeDemo
//
//  Created by 杨晴贺 on 16/7/25.
//  Copyright © 2016年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BridgeDemo.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BridgeDemo *demo = [[BridgeDemo alloc]init] ;
        [demo bridgeDemo] ;
        NSLog(@"-----------") ;
        [demo bridgeRetainedDemo] ;
        NSLog(@"-----------") ;
        [demo rBridgeDemo] ;
    }
    return 0;
}
