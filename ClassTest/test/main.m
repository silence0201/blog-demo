//
//  main.m
//  test
//
//  Created by 杨晴贺 on 8/19/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyArray.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *array = @[@1,@2,@3] ;
        NSLog(@"%@",[NSArray class]) ;
        NSLog(@"%@",[[NSArray alloc] class]) ;
        NSLog(@"%@",[array class]) ;
        
        MyArray *myarray = [[MyArray alloc]init] ;
        MyArray *arry = [[NSArray alloc]init] ;
        
        NSLog(@"%@",[MyArray class]) ;
        NSLog(@"%@",[[MyArray alloc] class]) ;
        NSLog(@"%@",[array class]) ;
        NSLog(@"%@",[myarray class]) ;
        
        if([array isKindOfClass:[NSArray class]]){
            NSLog(@"YES") ;
        }
        
        if ([myarray isKindOfClass:[NSArray class]]) {
            NSLog(@"YES") ;
        }
        
        if([myarray isMemberOfClass:[NSArray class]]){
            NSLog(@"YES") ;
        }else{
            NSLog(@"NO") ;
        }
        
        if ([arry isMemberOfClass:[NSArray class]]) {
            NSLog(@"YES") ;
        }else{
            NSLog(@"NO") ;
        }
    }
    return 0;
}
