//
//  UIImage+SDExtend.m
//  Category
//
//  Created by fqq3 on 17/2/23.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "UIImage+SDExtend.h"

@implementation UIImage (SDExtend)
/** 
 自定义一种颜色,返回一个自定义尺寸,不透明的UIImage 
 */
+ (UIImage *)sd_imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = (CGRect){{0.0f,0.0f},size};
    
    //开启一个图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    
    //获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, rect);
    
    //获取图像
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

/** 
 自定义一种颜色,返回一个 1 * 1 不透明的UIImage
 */
+ (UIImage *)sd_imageWithColor:(UIColor *)color {
    
    CGSize size = CGSizeMake(1.0f, 1.0f);
    
    return [self sd_imageWithColor:color size:size];
}


/**
 自定义一种颜色,返回一个完全变色的UIImage
 */
- (UIImage *)sd_imageWithTintColor:(UIColor *)tintColor {
    return [self sd_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

/**
 自定义一种颜色,返回一个变色但保持背景色的UIImage
 */
- (UIImage *)sd_imageWithGradientTintColor:(UIColor *)tintColor {
    return [self sd_imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

/**
 改变图片的颜色
 */
- (UIImage *)sd_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
