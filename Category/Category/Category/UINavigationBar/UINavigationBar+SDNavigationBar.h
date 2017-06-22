//
//  UINavigationBar+SDNavigationBar.h
//  Category
//
//  Created by fqq3 on 17/6/20.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 导航栏 UINavigationBar 分类
@interface UINavigationBar (SDNavigationBar) <UINavigationBarDelegate>
/** 设置导航栏所有 BarButtonItem 透明度 */
- (void)sd_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移多少距离 */
- (void)sd_setTranslationY:(CGFloat)translationY;

@end


#pragma mark - 导航栏 UIColor 分类
@interface UIColor (SDNavigationBar)
/** 设置全局 barTintColor */
+ (void)sd_setDefaultNavBarBarTintColor:(UIColor *)color;

/** 设置全局 tintColor */
+ (void)sd_setDefaultNavBarTintColor:(UIColor *)color;

/** 设置全局 titleColor */
+ (void)sd_setDefaultNavBarTitleColor:(UIColor *)color;

/** 设置全局 statusBarStyle */
+ (void)sd_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

@end


#pragma mark - 导航栏自定义 UIViewController 分类
@interface UIViewController (SDNavigationBar)
/** 记录当前控制器 navigationBar barTintColor */
- (void)sd_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)sd_navBarBarTintColor;

/** 记录当前控制器 navigationBar backgroundAlpha */
- (void)sd_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)sd_navBarBackgroundAlpha;

/** 记录当前控制器 navigationBar tintColor */
- (void)sd_setNavBarTintColor:(UIColor *)color;
- (UIColor *)sd_navBarTintColor;

/** 记录当前控制器 titleColor */
- (void)sd_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)sd_navBarTitleColor;

/** 记录当前控制器 statusBarStyle */
- (void)sd_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)sd_statusBarStyle;

/** 记录当前控制器 custom navigationBar */
- (void)sd_setCustomNavBar:(UINavigationBar *)navBar;

@end



