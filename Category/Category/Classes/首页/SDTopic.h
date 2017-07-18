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
@property (assign, nonatomic, getter=isSina_v) BOOL sina_v;
@property (assign, nonatomic, getter=isIs_gif) BOOL is_gif;


/****** 额外的辅助属性 ******/

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentF;
/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect pictureF;

/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceF;

/** 视频控件的frame */
@property (nonatomic, assign, readonly) CGRect videoF;
/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;
/** 图片是否太大 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;

@property (assign, nonatomic) NSInteger cache_version;

@property (copy, nonatomic) NSString *created_at;

@property (copy, nonatomic) NSString *ID;

@property (copy, nonatomic) NSString *voicelength;

@property (strong, nonatomic) SDComment *top_cmt;

@property (copy, nonatomic) NSString *repost;

@property (copy, nonatomic) NSString *bimageuri;

@property (copy, nonatomic) NSString *text;

@property (copy, nonatomic) NSString *theme_type;

@property (copy, nonatomic) NSString *hate;

@property (copy, nonatomic) NSString *ding;

@property (copy, nonatomic) NSString *comment;

@property (copy, nonatomic) NSString *passtime;

@property (assign, nonatomic) SDNewlistType type;

@property (copy, nonatomic) NSString *tag;

@property (copy, nonatomic) NSString *theme_name;

@property (copy, nonatomic) NSString *create_time;

@property (copy, nonatomic) NSString *favourite;

@property (strong, nonatomic) NSArray *themes;

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *pictureH;

@property (copy, nonatomic) NSString *status;

@property (copy, nonatomic) NSString *bookmark;

@property (copy, nonatomic) NSString *cai;

@property (copy, nonatomic) NSString *screen_name;

@property (copy, nonatomic) NSString *profile_image;

@property (copy, nonatomic) NSString *love;

@property (copy, nonatomic) NSString *user_id;

@property (copy, nonatomic) NSString *theme_id;

@property (copy, nonatomic) NSString *original_pid;

@property (assign, nonatomic) NSInteger t;

@property (copy, nonatomic) NSString *weixin_url;

@property (copy, nonatomic) NSString *voiceuri;

@property (copy, nonatomic) NSString *videouri;

@property (copy, nonatomic) NSString *pictureW;

@property (nonatomic, copy) NSString *image1;


@end
