
//
//  NSDate+SDExtension.m
//  Category
//
//  Created by fqq3 on 17/4/21.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "NSDate+SDExtension.h"

@implementation NSDate (SDExtension)
- (NSDateComponents *)deltaFrom:(NSDate *)from {
    // 创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 时间属性
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}

/**
 是否为今年
 */
- (BOOL)isThisYear {
    // 创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:(NSCalendarUnitYear) fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:(NSCalendarUnitYear) fromDate:self];
    
    return nowYear == selfYear;
}

/**
 是否为今天
 */
- (BOOL)isToday {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM--dd";
    
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    NSString *selfStr = [fmt stringFromDate:self];
    
    return [nowStr isEqualToString:selfStr];
}

/**
 是否为昨天
 */
- (BOOL)isYesterday {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM--dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    // 创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

@end
