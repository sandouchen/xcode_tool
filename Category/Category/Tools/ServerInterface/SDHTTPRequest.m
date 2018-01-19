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
static NSString *const serverPrefix = @"http://api.budejie.com/api/api_open.php";
#else
// 正式环境
static NSString *const serverPrefix = @"http://api.budejie.com/api/api_open.php";
#endif

@implementation SDHTTPRequest
+ (void)newListWithType:(NSInteger)type andMaxtime:(NSString *)maxtime andList:(NSString *)list success:(SDHttpRequestSuccess)success failure:(SDHttpRequestFailed)failure {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = list;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(type);
    
    if (maxtime) parameters[@"maxtime"] = maxtime;
    
    [SDNetworkHelper GET:serverPrefix parameters:parameters success:success failure:failure];
}

+ (void)recommendListWithSuccess:(SDHttpRequestSuccess)success andFailure:(SDHttpRequestFailed)failure {
    [SDNetworkHelper GET:serverPrefix parameters:@{@"a" : @"category", @"c" : @"subscribe"} success:success failure:failure];
}

+ (void)recommendListWithCategory_id:(NSInteger)category_id withPage:(NSInteger)page Success:(SDHttpRequestSuccess)success andFailure:(SDHttpRequestFailed)failure {
    [SDNetworkHelper GET:serverPrefix parameters:@{@"a" : @"list", @"c" : @"subscribe", @"category_id" : @(category_id), @"page" : @(page)} success:success failure:failure];
}

+ (void)recommendTagWithSuccess:(SDHttpRequestSuccess)success andFailure:(SDHttpRequestFailed)failure {
    [SDNetworkHelper GET:serverPrefix parameters:@{@"a" : @"tag_recommend", @"c" : @"topic", @"action" : @"sub"} success:success failure:failure];
}

/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data {
    if(data == nil) return nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
