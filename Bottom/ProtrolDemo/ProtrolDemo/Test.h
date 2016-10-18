//
//  Test.h
//  ProtrolDemo
//
//  Created by 杨晴贺 on 8/14/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Test <NSObject>


@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *age ;

- (void)print ;


@end
