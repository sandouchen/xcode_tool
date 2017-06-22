//
//  UIImage+SDExtend.h
//  Category
//
//  Created by fqq3 on 17/2/23.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SDExtend)
/**
 自定义一种颜色,返回一个 1 * 1 不透明的UIImage
 */
+ (UIImage *)sd_imageWithColor:(UIColor *)color;

/**
 自定义一种颜色,返回一个自定义尺寸,不透明的UIImage
 */
+ (UIImage *)sd_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 自定义一种颜色,返回一个完全变色的UIImage
 */
- (UIImage *)sd_imageWithTintColor:(UIColor *)tintColor;

/**
 自定义一种颜色,返回一个变色但保持背景色的UIImage
 */
- (UIImage *)sd_imageWithGradientTintColor:(UIColor *)tintColor;

/**
 *  从指定的UIView中截图：UIView转UIImage
 */
+ (UIImage *)sd_cutFromView:(UIView *)view;

/**
 *  直接截屏
 */
+ (UIImage *)sd_cutScreen;

/**
 *  从指定的UIImage和指定Frame截图：
 */
- (UIImage *)sd_cutWithFrame:(CGRect)frame;

/**
 *  拉伸图片:自定义比例
 */
+(UIImage *)sd_resizeWithImageName:(NSString *)name leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap;

/**
 *  拉伸图片
 */
+ (UIImage *)sd_resizeWithImageName:(NSString *)name;

/**
 *  图片取消渲染
 */
+ (UIImage *)sd_imageWithOriRenderingImage:(NSString *)imageName;

/**
 *  图片画圆角
 */
- (UIImage *)sd_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius;

/**
 *  图片画圆角
 */
- (UIImage *)sd_circleImage;

@end
