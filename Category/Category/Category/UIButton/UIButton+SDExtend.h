//
//  UIButton+SDExtend.h
//  Category
//
//  Created by fqq3 on 17/3/7.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 设置按钮图片和标题位置
 */
typedef NS_ENUM(NSInteger, SDImagePosition) {
    SDImagePositionLeft = 0,           //图片在左，文字在右，默认
    SDImagePositionRight = 1,          //图片在右，文字在左
    SDImagePositionTop = 2,            //图片在上，文字在下
    SDImagePositionBottom = 3,         //图片在下，文字在上
};

@interface UIButton (SDExtend)
/**
 快速生成一个含有Title & TitleColor & font & BackgroundColor的按钮 
 font = 0(默认字体)
 */
+ (UIButton *)sd_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(CGFloat)font BackgroundColor:(UIColor *)bgColor frame:(CGRect)frame sizeToFit:(BOOL)fit target:(id)target action:(SEL)action;

/**
 快速生成一个含有BackgroundImage的按钮
 */
+ (UIButton *)sd_buttonWithBgImage:(NSString *)image highlImage:(NSString *)highlImage frame:(CGRect)frame sizeToFit:(BOOL)fit target:(id)target action:(SEL)action;

/**
 快速生成一个含有Image & Title & Font & TitleColor的按钮 
 font = 0(默认字体)
 */
+ (UIButton *)sd_buttonWithImage:(NSString *)image highlImage:(NSString *)highlImage title:(NSString *)title titleColor:(UIColor *)titleColor font:(CGFloat)font frame:(CGRect)frame sizeToFit:(BOOL)fit target:(id)target action:(SEL)action;

/**
 *UIButton实现文字和图片的自由排列 
 *注意：代码实现要在本方法后面加 [btn sizeToFit];
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)sd_setImagePosition:(SDImagePosition)postion spacing:(CGFloat)spacing;

@end
