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
 @param page 当前所加载的页码数，默认为0
 @param type 1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
 @param maxtime 第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容
 @param success 成功Block
 @param failure 失败Block
 */
+ (void)newListWithList:(NSString *)list withPage:(NSInteger)page withType:(NSInteger)type withMaxtime:(NSString *)maxtime success:(SDHttpRequestSuccess)success failure:(SDHttpRequestFailed)failure;

/**
 获取推荐关注左边数据

 @param success 成功Block
 @param failure 失败Block
 */
+ (void)recommendListWithSuccess:(SDHttpRequestSuccess)success andFailure:(SDHttpRequestFailed)failure;

/**
 获取推荐关注右边数据

 @param category_id 要查询的推荐标签的id
 @param success 成功Block
 @param failure 失败Block
 */
+ (void)recommendListWithCategory_id:(NSInteger)category_id withPage:(NSInteger)page Success:(SDHttpRequestSuccess)success andFailure:(SDHttpRequestFailed)failure;


/**
 获取推荐标签数据

 @param success 成功Block
 @param failure 失败Block
 */
+ (void)recommendTagWithSuccess:(SDHttpRequestSuccess)success andFailure:(SDHttpRequestFailed)failure;

/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data;
@end
