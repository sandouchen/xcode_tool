//
//  NSObject+SDProperty.h
//  SD_Notes
//
//  Created by fqq3 on 16/6/29.
//  Copyright © 2016年 sandouchan. All rights reserved.
//  通过解析字典自动生成属性代码

#import <Foundation/Foundation.h>

@interface NSObject (SDProperty)

/**
 *  通过解析字典自动生成属性代码
 */
+ (void)createPropertyCodeWithDict:(NSDictionary *)dict;

@end
