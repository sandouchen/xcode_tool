//
//  UIButton+SDExtend.m
//  Category
//
//  Created by fqq3 on 17/3/7.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "UIButton+SDExtend.h"

@implementation UIButton (SDExtend)
/**
 快速生成一个含有Title & TitleColor & font & BackgroundColor的按钮
 
 @param font 字体大小, front = 0(默认字体)
 */
+ (UIButton *)sd_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(CGFloat)font BackgroundColor:(UIColor *)bgColor frame:(CGRect)frame sizeToFit:(BOOL)fit target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [btn setFrame:frame];
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setTitleColor:titleColor forState:(UIControlStateNormal)];
    [btn setBackgroundColor:bgColor];
    
    if (font > 0) btn.titleLabel.font = [UIFont systemFontOfSize:font];
    
    if (fit) [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return btn;
}

/**
 快速生成一个含有BackgroundImage的按钮
 */
+ (UIButton *)sd_buttonWithBgImage:(NSString *)image highlImage:(NSString *)highlImage frame:(CGRect)frame sizeToFit:(BOOL)fit target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [btn setFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [btn setBackgroundImage:[UIImage imageNamed:highlImage] forState:(UIControlStateHighlighted)];
    
    if (fit) [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return btn;
}

/**
 快速生成一个含有Image & Title & Font & TitleColor的按钮
 
 @param font 字体大小, front = 0(默认字体)
 */
+ (UIButton *)sd_buttonWithImage:(NSString *)image highlImage:(NSString *)highlImage title:(NSString *)title titleColor:(UIColor *)titleColor font:(CGFloat)font frame:(CGRect)frame sizeToFit:(BOOL)fit target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [btn setFrame:frame];
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setTitleColor:titleColor forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:highlImage] forState:(UIControlStateHighlighted)];
    
    if (font > 0) btn.titleLabel.font = [UIFont systemFontOfSize:font];
    
    if (fit) [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return btn;
}

/**
 *UIButton实现文字和图片的自由排列
 *注意：代码实现要在本方法后面加 [btn sizeToFit];
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)sd_setImagePosition:(SDImagePosition)postion spacing:(CGFloat)spacing {
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];
    
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    
    //image中心移动的x距离
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;
    //image中心移动的y距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;
    //label中心移动的x距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;
    //label中心移动的y距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;
    
    switch (postion) {
        case SDImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case SDImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case SDImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
            
        case SDImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
            
        default:
            break;
    }
}

@end
