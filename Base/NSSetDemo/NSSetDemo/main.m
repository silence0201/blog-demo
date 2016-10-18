//
//  main.m
//  NSSetDemo
//
//  Created by 杨晴贺 on 8/31/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableSet *set = [NSMutableSet set] ;
        NSArray *array1 = @[@(1),@(2)] ;
        NSArray *array2 = @[@(1),@(2)] ;
        
        NSLog(@"%d",[array1 isEqualToArray:array2]) ;
        
        [set addObject:array1] ;
        [set addObject:array2] ;
        
        NSLog(@"%@",set) ;
        
        NSMutableArray *array3 = [@[@(1)] mutableCopy] ;
        [set addObject:array3] ;
        
        NSLog(@"%@",set) ;
        
        [array3 addObject:@(2) ] ;
        
        NSLog(@"%@",set) ;
        
        NSSet *setCopy = [set copy] ;
        NSLog(@"%@",setCopy) ;
        
    }
    return 0;
}
