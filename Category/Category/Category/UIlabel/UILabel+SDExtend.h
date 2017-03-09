//
//  UILabel+SDExtend.h
//  Category
//
//  Created by fqq3 on 17/3/6.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SDStrIsEmpty(str) ([str isKindOfClass:[NSNull class]] || [str length] < 1 ? YES : NO || [str isEqualToString:@"(null)"] || [str isEqualToString:@"null"])

@interface UILabel (SDExtend)
/** 创建label */
+ (UILabel *)sd_labelWithFrame:(CGRect)frame title:(NSString *)title font:(CGFloat)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;

/** 有删除线的label */
+ (void)sd_delLineLabel:(UILabel *)label withColor:(UIColor *)color;

/** 有下划线的label */
+ (void)sd_underlineLabel:(UILabel *)label withColor:(UIColor *)color;

/** 改变label行间距 */
+ (void)sd_labelLineSpaceWithLabel:(UILabel *)label LineSpace:(CGFloat)space;

/** 改变label字间距 */
+ (void)sd_labelWordSpaceWithLabel:(UILabel *)label WordSpace:(CGFloat)space;

/** 改变行间距和字间距 */
+ (void)sd_labelSpaceWithLabel:(UILabel *)label lineSpace:(CGFloat)lineSpace wordSpace:(float)wordSpace;
@end
