//
//  CustomObject.h
//  LuaScriptCoreDemo
//
//  Created by 杨晴贺 on 11/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "LSCObjectClass.h"

@interface CustomObject : LSCObjectClass

@property (nonatomic,strong) NSString *name ;

- (void)speak ;
- (void)walk ;

@end
