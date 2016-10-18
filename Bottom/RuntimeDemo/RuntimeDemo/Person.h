//
//  Person.h
//  RuntimeDemo
//
//  Created by 杨晴贺 on 8/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersonAction <NSObject>

@optional
- (void)eat ;

@end

@interface Person : NSObject

+ (instancetype)sharedInstance ;
- (void)helloword2 ;
- (void)getCustomMemberOfTheClassProperty ;
- (void)getMethodFormClass ;

- (void)respondsTest ;

- (void)run ;
- (void)sleep ;
- (void)walk ;



@end
