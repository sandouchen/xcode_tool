//
//  SDCommonConst.h
//  SD_Notes
//
//  Created by fqq3 on 16/7/28.
//  Copyright © 2016年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 改变Placerholder颜色 */
UIKIT_EXTERN NSString *const SDPlacerholderColor;

/** 改变Placerholder字体 */
UIKIT_EXTERN NSString *const SDPlacerholderFont;

/** 自定义 TabBar */
UIKIT_EXTERN NSString *const SDTabBarKeyPath;

/** 导航栏高度 */
UIKIT_EXTERN const CGFloat SDNavigationBarH;

/** TabBar高度 */
UIKIT_EXTERN const CGFloat SDTabBarH;

/** 精华页面标签栏高度 */
UIKIT_EXTERN const CGFloat SDTitlesViewH;

/** 图片最大高度 */
UIKIT_EXTERN const CGFloat SDPictureMaxH;

/** 图片缩小高度 */
UIKIT_EXTERN const CGFloat SDPictureSmallH;

/** 布局间距 - 5 */
UIKIT_EXTERN const CGFloat SDLayoutMargin_5;
/** 布局间距 - 8 */
UIKIT_EXTERN const CGFloat SDLayoutMargin_8;
/** 布局间距 - 10 */
UIKIT_EXTERN const CGFloat SDLayoutMargin_10;

/**
 精华页面返回自定义类型的帖子

 - SDAllView: 1为全部
 - SDVideoView: 41为视频
 - SDVoiceView: 31为音频
 - SDPictureView: 10为图片
 - SDWordView: 29为段子
 */
typedef NS_ENUM(NSInteger, SDNewlistType) {
    SDAllView     = 1,
    SDVideoView   = 41,
    SDVoiceView   = 31,
    SDPictureView = 10,
    SDWordView    = 29
};

typedef NS_ENUM(NSInteger, RWTGlobalConstants) {
    RWTPinSizeMin  = 1,
    RWTPinSizeMax  = 5,
    RWTPinCountMin = 100,
    RWTPinCountMax = 500
};

typedef NS_OPTIONS(NSUInteger, SDControlState) {
    SDControlStateNormal      = 0,
    SDControlStateHighlighted = 1 << 0,
    SDControlStateDisabled    = 1 << 1,
    SDControlStateSelected    = 1 << 2
};

