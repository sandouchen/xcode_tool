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
@end
