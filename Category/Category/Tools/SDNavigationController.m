//
//  SDNavigationController.m
//  Category
//
//  Created by fqq3 on 17/6/2.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDNavigationController.h"

@interface SDNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>
/** 记录右滑状态 */
@property (nonatomic, strong) id popDelegate;
@end

@implementation SDNavigationController
/**
 * 当第一次使用这个类的时候,会调用一次
 */
+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    
    navBar.translucent = YES;
    
    // 设置导航栏背景图片
    [navBar setBackgroundImage:[UIImage sd_imageWithColor:[UIColor yellowColor]] forBarMetrics:(UIBarMetricsDefault)];
    
    // 设置导航栏标题属性
    [navBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : [UIColor redColor]}];
    
    UIBarButtonItem *navItem = [UIBarButtonItem appearanceWhenContainedIn:[self class], nil];
    
    // 设置导航栏按钮文字颜色
    [navItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor redColor]} forState:(UIControlStateNormal)];
    
    [navItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]} forState:(UIControlStateHighlighted)];
    
    [navItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:(UIControlStateDisabled)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fullScreenSlideBack];
}

/*
#pragma mark - 系统默认滑动返回
- (void)defaultSlideBack {
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    self.delegate = self;
}

#pragma mark - 系统默认滑动返回代理 (注意：用全屏手势这里要注释)
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == [self.viewControllers firstObject]) {
        // 如果展示的控制器是根控制器，就还原pop手势代理
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }
}
*/

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

#pragma mark - 全屏滑动返回代理 (注意：用系统默认滑动返回这里要注释)
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return (self.topViewController != [self.viewControllers firstObject]);
}

#pragma mark - 自定义返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断是否第一个控制器
    if (self.childViewControllers.count > 0) {
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
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
        
        // 清空代理(让导航控制器重新设置这个功能)(注意：用全屏手势这句要注释)
//        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
