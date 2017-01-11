//
//  CustomObject.m
//  LuaScriptCoreDemo
//
//  Created by 杨晴贺 on 11/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "CustomObject.h"

@implementation CustomObject

-(void)speak{
    NSLog(@"%@ speak",self.name) ;
}

- (void)walk{
    NSLog(@"%@ walk",self.name) ;
}

@end
