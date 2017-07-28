//
//  UIViewController+SDCurrentNav.h
//  Category
//
//  Created by fqq3 on 2017/7/24.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SDCurrentNav)

/**
 从自定义控件 push 到另一个控制器
 */
+ (UIViewController *)currentView:(UIView *)view;
@end
