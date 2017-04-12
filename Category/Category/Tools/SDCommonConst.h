//
//  SDCommonConst.h
//  SD_Notes
//
//  Created by fqq3 on 16/7/28.
//  Copyright © 2016年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN const CGFloat XMGRed;
UIKIT_EXTERN const CGFloat XMGGreen;
UIKIT_EXTERN const CGFloat XMGBlue;
UIKIT_EXTERN const CGFloat XMGAlpha;
UIKIT_EXTERN const int XMGAge;

/** 改变Placerholder颜色 */
UIKIT_EXTERN NSString *const SDPlacerholderColor;
UIKIT_EXTERN NSString *const XMGName;

typedef NS_ENUM(NSInteger, RWTLeftMenuTopItemType) {
    RWTLeftMenuTopItemMain,
    RWTLeftMenuTopItemShows,
    RWTLeftMenuTopItemSchedule
};

typedef NS_ENUM(NSInteger, RWTGlobalConstants) {
    RWTPinSizeMin  = 1,
    RWTPinSizeMax  = 5,
    RWTPinCountMin = 100,
    RWTPinCountMax = 500
};

typedef NS_OPTIONS(NSUInteger, SDControlState) {
    SDControlStateNormal       = 0,
    SDControlStateHighlighted  = 1 << 0,
    SDControlStateDisabled     = 1 << 1,
    SDControlStateSelected     = 1 << 2
};

