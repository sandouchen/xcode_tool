//
//  SDClearCache.h
//  Category
//
//  Created by fqq3 on 17/5/27.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDClearCache : NSObject
/**
 *  获取cache文件夹的大小
 *
 *  @return 返回path路径下文件夹的大小
 */
+ (NSString *)getCacheSize;

/**
 *  清除cache文件夹的缓存
 *
 *  @return 是否清除成功
 */
+ (BOOL)clearCache;
@end
