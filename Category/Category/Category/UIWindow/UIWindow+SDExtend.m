//
//  UIWindow+SDExtend.m
//  Category
//
//  Created by fqq3 on 2017/8/28.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "UIWindow+SDExtend.h"

@implementation UIWindow (SDExtend)
/**
 选择系统首次启动进入的控制器
 
 @param firstViewController 首次启动控制器
 @param secondViewController 非首次启动控制器
 */
- (void)chooseFirstStartViewController:(UIViewController *)firstViewController orSecondStartViewController:(UIViewController *)secondViewController {
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [SDUserDefaults objectForKey:SDCurrentVer];
    
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = SDCurrentVer;
    
    if ([currentVersion isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
        self.rootViewController = secondViewController;
        
    } else { // 这次打开的版本和上一次不一样，显示新特性
        self.rootViewController = firstViewController;
        
        // 将当前的版本号存进沙盒
        [SDUserDefaults setObject:currentVersion forKey:SDCurrentVer];
        [SDUserDefaults synchronize];
    }
}
@end
