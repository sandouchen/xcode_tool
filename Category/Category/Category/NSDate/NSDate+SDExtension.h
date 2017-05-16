//
//  NSDate+SDExtension.h
//  Category
//
//  Created by fqq3 on 17/4/21.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SDExtension)
/**
 比较2个时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 是否为今年
 */
- (BOOL)isThisYear;

/**
 是否为今天
 */
- (BOOL)isToday;

/**
 是否为昨天
 */
- (BOOL)isYesterday;

@end
