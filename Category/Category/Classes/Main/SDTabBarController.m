//
//  SDTabBarController.m
//  Category
//
//  Created by fqq3 on 17/6/6.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDTabBarController.h"
#import "SDNavigationController.h"
#import "SDTabBar.h"
#import "JPFPSStatus.h"

@interface SDTabBarController ()

@end

@implementation SDTabBarController
+ (void)initialize {
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:[self class], nil];
    
    [item setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor grayColor]} forState:(UIControlStateNormal)];
    
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor]} forState:(UIControlStateSelected)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] open];
#endif
}

#pragma mark - 添加子控制器（纯代码创建时使用）
- (void)setupChildViewControllers {
    // 添加子控制器
    
    
    // 更换tabBar
    [self setValue:[[SDTabBar alloc] init] forKeyPath:SDTabBarKeyPath];
}

#pragma mark - 初始化子控制器（纯代码创建时使用）
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    
    if (image.length) {
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    SDNavigationController *nav = [[SDNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
