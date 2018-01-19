//
//  UIWindow+SDExtend.h
//  Category
//
//  Created by fqq3 on 2017/8/28.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (SDExtend)
/**
 选择系统首次启动进入的控制器

 @param firstViewController 首次启动控制器
 @param secondViewController 非首次启动控制器
 */
- (void)chooseFirstStartViewController:(UIViewController *)firstViewController orSecondStartViewController:(UIViewController *)secondViewController;
@end
