//
//  UIColor+SDExtend.h
//  Category
//
//  Created by fqq3 on 17/3/2.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SDExtend)
/** 
 十六进制的颜色转换为UIColor
 */
+ (UIColor *)sd_colorWithHexString:(NSString *)color;

/**
 十六进制的颜色转换为UIColor + Alpha
 */
+ (UIColor *)sd_colorWithHexString:(NSString *)color withAlpha:(CGFloat)alpha;

@end
