//
//  UIColor+SDExtend.m
//  Category
//
//  Created by fqq3 on 17/3/2.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "UIColor+SDExtend.h"

@implementation UIColor (SDExtend)
/**
 十六进制的颜色转换为UIColor + Alpha
 */
+ (UIColor *)sd_colorWithHexString:(NSString *)color withAlpha:(CGFloat)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    if ([cString length] == 8) {
        //argb
        NSRange range;
        range.location = 0;
        range.length = 2;
        //alpha
        NSString *astr = [cString substringWithRange:range];
        unsigned int aa;
        [[NSScanner scannerWithString:astr] scanHexInt:&aa];
        alpha = (float)aa/255.0;
        
        cString = [cString substringFromIndex:2];
    }
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

/**
 颜色转换 IOS 中十六进制的颜色转换为UIColor
 */
+ (UIColor *)sd_colorWithHexString:(NSString *)color {
    return [UIColor sd_colorWithHexString:color withAlpha:1.0f];
}
@end
