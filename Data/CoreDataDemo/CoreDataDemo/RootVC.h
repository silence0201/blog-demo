//
//  RootVC.h
//  CoreDataDemo
//
//  Created by 杨晴贺 on 16/7/7.
//  Copyright © 2016年 caigee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeEntityManager.h"

@interface RootVC : UIViewController
{
    NSMutableArray      *timesArray;
    TimeEntityManager   *sharedManager;
    
    int currentNmumber;

}

@end
