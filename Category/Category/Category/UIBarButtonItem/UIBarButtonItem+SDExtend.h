//
//  UIBarButtonItem+SDExtend.h
//  Category
//
//  Created by fqq3 on 17/3/6.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 UIBarButtonItem是否偏移

 - ContentInstesZero: 不偏移
 - ContentInstesLeft: 向左偏移 -15
 - ContentInstesRight: 向右偏移 -15
 */
typedef NS_ENUM(NSInteger, ContentInstes) {
    ContentInstesZero = 0,
    ContentInstesLeft = 1,
    ContentInstesRight = 2,
};

@interface UIBarButtonItem (SDExtend)

/**
 *创建UIBarButtonItem，高亮图片
 */
+ (UIBarButtonItem *)sd_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage insets:(ContentInstes)insets;

/**
 *创建UIBarButtonItem，高亮图片
 */
+ (UIBarButtonItem *)sd_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage insets:(ContentInstes)insets;

/**
 *创建UIBarButtonItem With Title
 */
+ (UIBarButtonItem *)sd_itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor Target:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage insets:(ContentInstes)insets;
@end
