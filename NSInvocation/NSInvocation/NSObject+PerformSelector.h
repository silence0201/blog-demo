//
//  NSObject+PerformSelector.h
//  NSInvocation
//
//  Created by 杨晴贺 on 8/26/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformSelector)

- (id)myPerformSelector:(SEL)aSelector withObject:(NSArray *)object ;

@end
