//
//  UINavigationItem+SDExtend.h
//  Category
//
//  Created by fqq3 on 2017/8/31.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIActivityIndicatorView 显示在navigationBar的位置
 */
typedef NS_ENUM(NSUInteger, SDNavBarLoaderPosition){
    /**
     *  居中
     */
    SDNavBarLoaderPositionCenter = 0,
    /**
     *  左边
     */
    SDNavBarLoaderPositionLeft,
    /**
     *  右边
     */
    SDNavBarLoaderPositionRight
};

@interface UINavigationItem (SDExtend)

/**
 *  添加并开始 UIActivityIndicatorView 动画
 */
- (void)startAnimatingAt:(SDNavBarLoaderPosition)position withActivityIndicatorViewColor:(UIColor *)color;

/**
 *  停止 UIActivityIndicatorView 动画
 */
- (void)stopAnimating;
@end
