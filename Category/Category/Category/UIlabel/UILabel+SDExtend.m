//
//  UILabel+SDExtend.m
//  Category
//
//  Created by fqq3 on 17/3/6.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "UILabel+SDExtend.h"

@implementation UILabel (SDExtend)
/** 创建label font = 0(默认字体) */
+ (UILabel *)sd_labelWithFrame:(CGRect)frame title:(NSString *)title font:(CGFloat)font color:(UIColor *)color alignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textAlignment = alignment;
    label.numberOfLines = 0;
    label.textColor = color;
    if (font > 0) label.font = [UIFont systemFontOfSize:font];
    return label;
}

/** 有删除线的label */
+ (void)sd_delLineLabel:(UILabel *)label withColor:(UIColor *)color {
    NSString *labelText = label.text;
    
    if (SDStrIsEmpty(labelText)) return;
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:labelText];
    
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, labelText.length)];
    
    [attri addAttribute:NSStrikethroughColorAttributeName value:color range:NSMakeRange(0, labelText.length)];
    
    [label setAttributedText:attri];
}

/** 有下划线的label */
+ (void)sd_underlineLabel:(UILabel *)label withColor:(UIColor *)color {
    
    NSString *labelText = label.text;
    
    if (SDStrIsEmpty(labelText)) return;
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:labelText];
    
    [attri addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, labelText.length)];
    
    [attri addAttribute:NSUnderlineColorAttributeName value:color range:NSMakeRange(0, labelText.length)];
    
    [label setAttributedText:attri];
}

/** 改变label行间距 */
+ (void)sd_labelLineSpaceWithLabel:(UILabel *)label LineSpace:(CGFloat)space {
    NSString *labelText = label.text;
    
    if (SDStrIsEmpty(labelText)) return;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

/** 改变label字间距 */
+ (void)sd_labelWordSpaceWithLabel:(UILabel *)label WordSpace:(CGFloat)space {
    NSString *labelText = label.text;
    
    if (SDStrIsEmpty(labelText)) return;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

/** 改变行间距和字间距 */
+ (void)sd_labelSpaceWithLabel:(UILabel *)label lineSpace:(CGFloat)lineSpace wordSpace:(float)wordSpace {
    NSString *labelText = label.text;
    
    if (SDStrIsEmpty(labelText)) return;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}
@end
