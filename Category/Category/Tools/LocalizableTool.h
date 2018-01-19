//
//  LocalizableTool.h
//  LocalizableDemo
//
//  Created by fqq3 on 17/6/12.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalizableTool : NSObject

/**
 获取当前资源文件
 */
+ (NSBundle *)bundle;

/**
 初始化语言文件
 */
+ (void)initLanguage;

/**
 获取应用当前语言
 */
+ (NSString *)getCurrentLanguage;

/**
 设置当前语言
 */
+ (void)setLanguage:(NSString *)language;

@end
