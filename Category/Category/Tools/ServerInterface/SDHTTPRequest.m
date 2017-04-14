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
static NSString *const serverPrefix;
#endif

@implementation SDHTTPRequest
+ (void)newListWithList:(NSString *)list withPer:(NSInteger)per withType:(NSInteger)type success:(SDHttpRequestSuccess)success failure:(SDHttpRequestFailed)failure {
    [SDNetworkHelper GET:serverPrefix parameters:@{@"a":list,  @"c":@"data", @"per":[NSString stringWithFormat:@"%zd", per], @"type":[NSString stringWithFormat:@"%zd", type]} success:success failure:failure];
}

+ (void)recommendListWithSuccess:(SDHttpRequestSuccess)success andFailure:(SDHttpRequestFailed)failure {
    [SDNetworkHelper GET:serverPrefix parameters:@{@"a" : @"category", @"c" : @"subscribe"} success:success failure:failure];
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
