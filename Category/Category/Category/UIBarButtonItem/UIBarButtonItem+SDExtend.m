//
//  UIBarButtonItem+SDExtend.m
//  Category
//
//  Created by fqq3 on 17/3/6.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "UIBarButtonItem+SDExtend.h"

@implementation UIBarButtonItem (SDExtend)
/**
 *创建UIBarButtonItem
 */
+ (UIBarButtonItem *)sd_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage insets:(ContentInstes)insets {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    // 设置尺寸
    [btn sizeToFit];
    
    if (ContentInstesZero == insets) [btn setContentEdgeInsets:UIEdgeInsetsZero];
    
    if (ContentInstesLeft == insets) [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    
    if (ContentInstesRight == insets) [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -15)];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 *创建UIBarButtonItem，高亮图片
 */
+ (UIBarButtonItem *)sd_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage insets:(ContentInstes)insets {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    
    // 设置尺寸
    [btn sizeToFit];
    
    if (ContentInstesZero == insets) [btn setContentEdgeInsets:UIEdgeInsetsZero];
    
    if (ContentInstesLeft == insets) [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    
    if (ContentInstesRight == insets) [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -15)];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 *创建UIBarButtonItem With Title
 */
+ (UIBarButtonItem *)sd_itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor Target:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage insets:(ContentInstes)insets {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置Title
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setTitleColor:titleColor forState:(UIControlStateNormal)];
    
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    // 设置尺寸
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (ContentInstesZero == insets) [btn setContentEdgeInsets:UIEdgeInsetsZero];
    
    if (ContentInstesLeft == insets) [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    
    if (ContentInstesRight == insets) {
        CGFloat imageWidth = btn.imageView.image.size.width;
        CGFloat labelWidth = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: btn.titleLabel.font}].width;
        
        CGFloat spacing = 5;
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing / 2, 0, -(labelWidth + spacing / 2));
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing / 2), 0, imageWidth + spacing / 2);
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    }
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
