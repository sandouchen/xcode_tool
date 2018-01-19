//
//  MBProgressHUD+SD.h
//  Category
//
//  Created by fqq3 on 2017/8/23.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface MBProgressHUD (SD)
/**
 显示Loading + 文字
 
 @param message 显示的文字
 @param view 要添加的view
 */
+ (MBProgressHUD *)showLoadingWithMessage:(NSString *)message toView:(UIView *)view;

/**
 只显示Loading
 
 @param view 要添加的view
 */
+ (void)showLoadingToView:(UIView *)view;

/**
 显示纯文字提示
 
 @param message 标题
 @param view 要添加的view
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

/**
 *  自定义图片的提示，自动消失
 *
 *  @param title    要显示的文字
 *  @param iconName 图片名/地址(建议不要太大的图片)
 *  @param view     要添加的view
 */
+ (MBProgressHUD *)showCustomIcon:(NSString *)iconName Title:(NSString *)title ToView:(UIView *)view;

/**
 *  自动消失成功提示，带默认图
 *
 *  @param success 要显示的文字
 *  @param view    要添加的view
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

/**
 *  自动消失错误提示,带默认图
 *
 *  @param error 要显示的错误文字
 *  @param view  要添加的View
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;

/**
 *  自动消失笑脸提示,带默认图
 *
 *  @param Info 要显示的文字
 *  @param view  要添加的View
 */
+ (void)showInfo:(NSString *)Info toView:(UIView *)view;

/**
 *  自动消失警告提示,带默认图
 *
 *  @param warn 要显示的文字
 *  @param view  要添加的View
 */
+ (void)showWarn:(NSString *)warn toView:(UIView *)view;

/**
 *  隐藏HUD
 *
 *  @param view superView
 */
+ (void)hideHUDForView:(UIView *)view;

/**
 *  快速从window中隐藏HUD
 */
+ (void)hideHUD;

@end
