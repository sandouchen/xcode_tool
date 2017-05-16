//
//  SDComment.h
//  Category
//
//  Created by fqq3 on 17/5/2.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SDUser;

@interface SDComment : NSObject
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) SDUser *user;
@end
