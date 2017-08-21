//
//  SDClearCache.m
//  Category
//
//  Created by fqq3 on 17/5/27.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDClearCache.h"

@implementation SDClearCache
+ (NSString *)getCacheSize {
    // 获取 cache 文件夹下的所有文件
    NSArray *subPathArr = [SDFileManager subpathsAtPath:SDCachePath];
    
    NSString *filePath  = nil;
    NSInteger totleSize = 0;
    
    for (NSString *subPath in subPathArr) {
        // 1. 拼接每一个文件的全路径
        filePath = [SDCachePath stringByAppendingPathComponent:subPath];
        // 2. 是否是文件夹，默认不是
        BOOL isDirectory = NO;
        // 3. 判断文件是否存在
        BOOL isExist = [SDFileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        // 4. 以上判断目的是忽略不需要计算的文件
        if (!isExist || isDirectory || [filePath containsString:@".DS"]) {
            // 过滤: 1. 文件夹不存在  2. 过滤文件夹  3. 隐藏文件
            continue;
        }
        
        // 5. 指定路径，获取这个路径的属性
        /**
         attributesOfItemAtPath: 文件夹路径
         该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因
         */
        NSDictionary *dict = [SDFileManager attributesOfItemAtPath:filePath error:nil];
        
        
        // 6. 获取每一个文件的大小
        NSInteger size = [dict[NSFileSize] integerValue];
        
        // 7. 计算总大小
        totleSize += size;
    }
    
    // 8. 将文件夹大小转换为 GB/MB/KB/B
    NSString *totleStr = nil;
    
    if (totleSize >= pow(10, 9)) {
        totleStr = [NSString stringWithFormat:@"%.2fGB", totleSize / pow(10, 9)];
        
    } else if (totleSize >= pow(10, 6)) {
        totleStr = [NSString stringWithFormat:@"%.2fMB",totleSize / pow(10, 6)];
        
    } else if (totleSize >= pow(10, 3)) {
        totleStr = [NSString stringWithFormat:@"%.2fKB", totleSize / pow(10, 3)];
        
    } else {
        totleStr = [NSString stringWithFormat:@"%zdB", totleSize];
    }
    
    return totleStr;
}

#pragma mark - 清除path文件夹下缓存大小
+ (BOOL)clearCache {
    // 拿到 cache 路径的下一级目录的子文件夹
    NSArray *subPathArr = [SDFileManager contentsOfDirectoryAtPath:SDCachePath error:nil];
    
    NSString *filePath = nil;
    
    NSError *error = nil;
    
    for (NSString *subPath in subPathArr) {
        filePath = [SDCachePath stringByAppendingPathComponent:subPath];
        
        // 删除子文件夹
        [SDFileManager removeItemAtPath:filePath error:&error];
        
        if (error) {
            return NO;
        }
    }
    return YES;
}

@end






















