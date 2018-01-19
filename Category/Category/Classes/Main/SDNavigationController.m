//
//  SDNavigationController.m
//  Category
//
//  Created by fqq3 on 17/6/2.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDNavigationController.h"

static const NSUInteger itemTitleFont = 20;

@interface SDNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation SDNavigationController
/**
 * 当第一次使用这个类的时候,会调用一次
 */
+ (void)initialize {
    /** WRNavigationBar 定义导航栏 */
    [UIColor wr_setDefaultNavBarBarTintColor:NavBarBarTintColor];
    [UIColor wr_setDefaultNavBarTitleColor:[UIColor redColor]];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    /** 自定义导航栏
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    
    navBar.translucent = YES;
    
    // 设置导航栏背景图片
    [navBar setBackgroundImage:[UIImage sd_imageWithColor:[UIColor yellowColor]] forBarMetrics:(UIBarMetricsDefault)];
    
    // 设置导航栏标题属性
    [navBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : [UIColor redColor]}];
     */
    
    // 设置导航栏按钮文字颜色
    UIBarButtonItem *navItem = [UIBarButtonItem appearance];
    
    [navItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:itemTitleFont], NSForegroundColorAttributeName : [UIColor purpleColor]} forState:(UIControlStateNormal)];
    
    [navItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]} forState:(UIControlStateHighlighted)];
    
    [navItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:(UIControlStateDisabled)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fullScreenSlideBackEnabled:YES];
}

#pragma mark - 选择是否需要全屏滑动返回功能
- (void)fullScreenSlideBackEnabled:(BOOL)enabled {
    if (enabled) {
        // 全屏滑动返回
        [self fullScreenSlideBack];
    }else {
        // 系统默认右滑返回（设置导航控制器为手势识别器的代理）
        self.interactivePopGestureRecognizer.delegate = self;
    }
}

#pragma mark - 全屏滑动返回
- (void)fullScreenSlideBack {
    // 防止手势冲突
    self.interactivePopGestureRecognizer.enabled = NO;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

#pragma mark - 手势识别器对象会调用这个代理方法来决定手势是否有效 YES : 手势有效, NO : 手势无效
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}

#pragma mark - 自定义返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断是否第一个控制器
    if (self.childViewControllers.count > 0) {
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:itemTitleFont];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        [backBtn sizeToFit];
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
