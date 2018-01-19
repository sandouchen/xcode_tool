//
//  LocalizableTool.m
//  LocalizableDemo
//
//  Created by fqq3 on 17/6/12.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "LocalizableTool.h"

static NSBundle *bundle = nil;

@implementation LocalizableTool
+ (NSBundle *)bundle {
    return bundle;
}

// 使用系统当前语言初始化
+ (void)initLanguage {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *sysLanguage = [[userDefaults objectForKey:@"AppleLanguages"] firstObject];
    if ([sysLanguage hasPrefix:@"zh"]) {
        if ([sysLanguage hasPrefix:@"zh-Hans"]) {
            // //简体
            sysLanguage = @"zh-Hans";
        }
        else{
            //繁体
            sysLanguage = @"zh-Hant";
        }
    }
    else {
        sysLanguage = @"en";
    }
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:sysLanguage ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];
    [userDefaults setValue:sysLanguage forKey:@"userLanguage"];
}

+ (NSString *)getCurrentLanguage {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *currentLanguage = [userDefaults valueForKey:@"userLanguage"];
    return currentLanguage;
}

+ (void)setLanguage:(NSString *)language {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];
    [userDefaults setValue:language forKey:@"userLanguage"];
    [userDefaults synchronize];
}

@end

