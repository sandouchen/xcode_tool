//
//  MBProgressHUD+SD.m
//  Category
//
//  Created by fqq3 on 2017/8/23.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "MBProgressHUD+SD.h"

static const NSUInteger duration = 2;

#define HUDWindow [UIApplication sharedApplication].keyWindow

@implementation MBProgressHUD (SD)
/**
 显示Loading + 文字

 @param message 显示的文字
 @param view 要添加的view
 */
+ (MBProgressHUD *)showLoadingWithMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) {
        view = HUDWindow;
    }
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
    
    return hud;
}

/**
 只显示Loading

 @param view 要添加的view
 */
+ (void)showLoadingToView:(UIView *)view {
    [self showLoadingWithMessage:nil toView:view];
}

/**
 显示纯文字提示

 @param message 标题
 @param view 要添加的view
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) {
        view = HUDWindow;
    }
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
    
    // 设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 自动消失
    [hud hideAnimated:YES afterDelay:duration];
    
    return hud;
}

/**
 *  自定义图片的提示，自动消失
 *
 *  @param title    要显示的文字
 *  @param iconName 图片名/地址(建议不要太大的图片)
 *  @param view     要添加的view
 */
+ (MBProgressHUD *)showCustomIcon:(NSString *)iconName Title:(NSString *)title ToView:(UIView *)view {
    if (view == nil) {
        view = HUDWindow;
    }
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.label.text = title;
    hud.label.numberOfLines = 0;
    
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
    
    // 设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    
    // 自动消失
    [hud hideAnimated:YES afterDelay:duration];
    
    return hud;
}

#pragma mark - 显示默认返回信息
/**
 *  自动消失错误提示,带默认图
 *
 *  @param error 要显示的错误文字
 *  @param view  要添加的View
 */
+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self showCustomIcon:@"MBProgressHUD.bundle/MBHUD_Error" Title:error ToView:view];
}

/**
 *  自动消失笑脸提示,带默认图
 *
 *  @param Info 要显示的文字
 *  @param view  要添加的View
 */
+ (void)showInfo:(NSString *)Info toView:(UIView *)view {
    [self showCustomIcon:@"MBProgressHUD.bundle/MBHUD_Info" Title:Info ToView:view];
}

/**
 *  自动消失警告提示,带默认图
 *
 *  @param warn 要显示的文字
 *  @param view  要添加的View
 */
+ (void)showWarn:(NSString *)warn toView:(UIView *)view {
    [self showCustomIcon:@"MBProgressHUD.bundle/MBHUD_Warn" Title:warn ToView:view];
}

/**
 *  自动消失成功提示，带默认图
 *
 *  @param success 要显示的文字
 *  @param view    要添加的view
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self showCustomIcon:@"MBProgressHUD.bundle/MBHUD_Success" Title:success ToView:view];
}

#pragma mark - 隐藏 HUD
/**
 *  隐藏HUD
 *
 *  @param view superView
 */
+ (void)hideHUDForView:(UIView *)view {
    if (view == nil) {
        view = HUDWindow;
    }
    
    [self hideHUDForView:view animated:YES];
}

/**
 *  快速从window中隐藏HUD
 */
+ (void)hideHUD {
    [self hideHUDForView:nil];
}
@end
