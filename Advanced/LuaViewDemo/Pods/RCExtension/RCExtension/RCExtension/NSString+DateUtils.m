//
//  NSString+DateUtils.m
//  HTlvyou_ERP
//
//  Created by Developer on 15/12/9.
//  Copyright © 2015年 海涛旅游. All rights reserved.
//

#import "NSString+DateUtils.h"

@implementation NSString (DateUtils)

- (NSString *)stringYearMonthDayCompareToday {
    if ([self isEqualToString:@""] ) {
        return @"";
    }
    NSDateFormatter *f = [[NSDateFormatter alloc]init];
    [f setDateFormat:@"yyyy-MM-dd HH:mm:SS"];
    NSDate *date = [f dateFromString:self];
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date  toDate:now  options:0];
    NSInteger diff = [comps day];
    if (diff == 0) {
        return [self timeStrWithFormatter:@"HH:mm"];
    }
    else if (diff == 1){
        return @"昨天";
    }
    else {
       return [self timeStrWithFormatter:@"yyyy-MM-dd"];
    }
}

- (NSString *)timeStrWithFormatter:(NSString *)formatterStr {
    NSDateFormatter *f = [[NSDateFormatter alloc]init];
    [f setDateFormat:@"yyyy-MM-dd HH:mm:SS"];
    NSDate *date = [f dateFromString:self];
    NSDateFormatter *needFormatter = [[NSDateFormatter alloc]init];
    [needFormatter setDateFormat:formatterStr];
    return [needFormatter stringFromDate:date];
}



@end
