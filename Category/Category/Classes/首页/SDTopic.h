//
//  SDTopic.h
//  Category
//
//  Created by fqq3 on 17/4/20.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SDComment;

@interface SDTopic : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *create_time;
/** 顶数量 */
@property (nonatomic, copy) NSString *ding;
/** 踩数量 */
@property (nonatomic, copy) NSString *cai;
/** 转发\分享数量 */
@property (nonatomic, copy) NSString *repost;
/** 评论数量 */
@property (nonatomic, copy) NSString *comment;
/** 最热评论 */
@property (nonatomic, strong) SDComment *top_cmt;
/** 帖子类型 */
@property (nonatomic, assign) SDNewlistType type;
/** 图片的真实宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的真实高度 */
@property (nonatomic, assign) CGFloat height;

/** 小图 */
@property (nonatomic, copy) NSString *small_image;
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;
/** 大图 */
@property (nonatomic, copy) NSString *large_image;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;


/***** 额外增加的属性 - 方便开发 *****/
/** 是否为gif动画图片 */
@property (nonatomic, assign) BOOL is_gif;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentF;
/** 是否为超长图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 是否会员 */
@property (assign, nonatomic, getter=isSina_v) BOOL sina_v;
/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

@end
