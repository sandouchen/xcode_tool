//
//  SDHTTPRequest.h
//  Category
//
//  Created by fqq3 on 17/4/12.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkHelper.h"

@interface SDHTTPRequest : NSObject
/**
 获取精华帖子

 @param list 参数值为list，如果想要获取“新帖”板块的帖子，则传入"newlist"即可
 @param per 每页显示的帖子数量，默认为20
 @param type 1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
 @param success 成功Block
 @param failure 失败Block
 */
+ (void)newListWithList:(NSString *)list withPer:(NSInteger)per withType:(NSInteger)type success:(SDHttpRequestSuccess)success failure:(SDHttpRequestFailed)failure;


/**
 获取推荐关注左边数据

 @param success 成功Block
 @param failure 失败Block
 */
+ (void)recommendListWithSuccess:(SDHttpRequestSuccess)success andFailure:(SDHttpRequestFailed)failure;

/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data;
@end
