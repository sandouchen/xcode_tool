//
//  SDHTTPRequest.m
//  Category
//
//  Created by fqq3 on 17/4/12.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDHTTPRequest.h"

/** 服务器地址 */
#ifdef DEBUG
// 测试环境
static NSString *const serverPrefix = @"https://www.baidu.com";
#else
// 正式环境
static NSString *const serverPrefix = @"https://www.baidu.com";
#endif

@implementation SDHTTPRequest
/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data {
    if(data == nil) { return nil; }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
