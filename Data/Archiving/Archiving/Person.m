//
//  Person.m
//  Archiving
//
//  Created by 杨晴贺 on 16/7/16.
//  Copyright © 2016年 silence. All rights reserved.
//

#import "Person.h"

@implementation Person

//进行归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"] ;
    [aCoder encodeInteger:self.age forKey:@"age"] ;
}
//进行解档
- (id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"] ;
        self.age = [aDecoder decodeIntegerForKey:@"age"] ;
    }
    return self ;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"name:%@---age:%ld",_name,_age] ;
}

@end
