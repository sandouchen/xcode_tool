


//
//  UINavigationBar+SDNavigationBar.m
//  Category
//
//  Created by fqq3 on 17/6/20.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "UINavigationBar+SDNavigationBar.h"

#pragma mark - UIColor
@interface UIColor (PrivateMethods)
+ (UIColor *)defaultNavBarBarTintColor;
+ (UIColor *)defaultNavBarTintColor;
+ (UIColor *)defaultNavBarTitleColor;
+ (UIStatusBarStyle)defaultStatusBarStyle;
+ (CGFloat)defaultNavBarBackgroundAlpha;
+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent;
+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent;

@end

@implementation UIColor (SDNavigationBar)

static char SDDefaultNavBarBarTintColorKey;
static char SDDefaultNavBarTintColorKey;
static char SDDefaultNavBarTitleColorKey;
static char SDDefaultStatusBarStyleKey;

+ (UIColor *)defaultNavBarBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &SDDefaultNavBarBarTintColorKey);
    return (color != nil) ? color : [UIColor whiteColor];
}

+ (void)sd_setDefaultNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &SDDefaultNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &SDDefaultNavBarTintColorKey);
    return (color != nil) ? color : [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
}

+ (void)sd_setDefaultNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &SDDefaultNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTitleColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &SDDefaultNavBarTitleColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}

+ (void)sd_setDefaultNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &SDDefaultNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIStatusBarStyle)defaultStatusBarStyle {
    id style = objc_getAssociatedObject(self, &SDDefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}

+ (void)sd_setDefaultStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &SDDefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (CGFloat)defaultNavBarBackgroundAlpha {
    return 1.0;
}

+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent {
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat newRed = fromRed + (toRed - fromRed) * percent;
    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat newBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:newAlpha];
}

+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent {
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}

@end


#pragma mark - UINavigationBar
@implementation UINavigationBar (SDNavigationBar)

static char SDBackgroundViewKey;
static int SDNavBarBottom = 64;

- (UIView*)backgroundView {
    return objc_getAssociatedObject(self, &SDBackgroundViewKey);
}

- (void)setBackgroundView:(UIView*)backgroundView {
    objc_setAssociatedObject(self, &SDBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// set navigationBar barTintColor
- (void)sd_setBackgroundColor:(UIColor *)color {
    if (self.backgroundView == nil) {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), SDNavBarBottom)];
        // _UIBarBackground is first subView for navigationBar
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
    }
    self.backgroundView.backgroundColor = color;
}

// set _UIBarBackground alpha (_UIBarBackground subviews alpha <= _UIBarBackground alpha)
- (void)sd_setBackgroundAlpha:(CGFloat)alpha {
    UIView *barBackgroundView = self.subviews.firstObject;
    barBackgroundView.alpha = alpha;
}

- (void)sd_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator {
    for (UIView *view in self.subviews) {
        if (hasSystemBackIndicator == YES) {
            // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            
            if (_UIBarBackgroundClass != nil) {
                if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                    view.alpha = alpha;
                }
            }
            
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            
            if (_UINavigationBarBackground != nil) {
                if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                    view.alpha = alpha;
                }
            }
        } else {
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO) {
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                
                if (_UIBarBackgroundClass != nil) {
                    if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                        view.alpha = alpha;
                    }
                }
                
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                
                if (_UINavigationBarBackground != nil) {
                    if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

// 设置导航栏在垂直方向上平移多少距离
- (void)sd_setTranslationY:(CGFloat)translationY {
    // CGAffineTransformMakeTranslation  平移
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

@end


#pragma mark - UIViewController
@interface UIViewController (PrivateMethods)
- (void)setPushToCurrentVCFinished:(BOOL)isFinished;

@end


#pragma mark - UINavigationController
@implementation UINavigationController (SDNavigationBar)

static CGFloat sdPopDuration = 0.12;
static int sdPopDisplayCount = 0;

- (CGFloat)sdPopProgress {
    CGFloat all = 60 * sdPopDuration;
    int current = MIN(all, sdPopDisplayCount);
    return current / all;
}

static CGFloat sdPushDuration = 0.10;
static int sdPushDisplayCount = 0;

- (CGFloat)sdPushProgress {
    CGFloat all = 60 * sdPushDuration;
    int current = MIN(all, sdPushDisplayCount);
    return current / all;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController sd_statusBarStyle];
}

- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor {
    [self.navigationBar sd_setBackgroundColor:barTintColor];
}

- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha {
    [self.navigationBar sd_setBackgroundAlpha:barBackgroundAlpha];
}

- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor {
    self.navigationBar.tintColor = tintColor;
}

- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor {
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
}

- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress {
    // change navBarBarTintColor
    UIColor *fromBarTintColor = [fromVC sd_navBarBarTintColor];
    UIColor *toBarTintColor = [toVC sd_navBarBarTintColor];
    UIColor *newBarTintColor = [UIColor middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
    
    // change navBarTintColor
    UIColor *fromTintColor = [fromVC sd_navBarTintColor];
    UIColor *toTintColor = [toVC sd_navBarTintColor];
    UIColor *newTintColor = [UIColor middleColor:fromTintColor toColor:toTintColor percent:progress];
    [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
    
    // change navBarTitleColor
    UIColor *fromTitleColor = [fromVC sd_navBarTitleColor];
    UIColor *toTitleColor = [toVC sd_navBarTitleColor];
    UIColor *newTitleColor = [UIColor middleColor:fromTitleColor toColor:toTitleColor percent:progress];
    [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
    
    // change navBar _UIBarBackground alpha
    CGFloat fromBarBackgroundAlpha = [fromVC sd_navBarBackgroundAlpha];
    CGFloat toBarBackgroundAlpha = [toVC sd_navBarBackgroundAlpha];
    CGFloat newBarBackgroundAlpha = [UIColor middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
    [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^ {
        SEL needSwizzleSelectors[4] = {
            NSSelectorFromString(@"_updateInteractiveTransition:"),
            @selector(popToViewController:animated:),
            @selector(popToRootViewControllerAnimated:),
            @selector(pushViewController:animated:)
        };
        
        for (int i = 0; i < 4;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [[NSString stringWithFormat:@"sd_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (NSArray<UIViewController *> *)sd_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        sdPopDisplayCount = 0;
    }];
    
    [CATransaction setAnimationDuration:sdPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self sd_popToViewController:viewController animated:animated];
    [CATransaction commit];
    return vcs;
}

- (NSArray<UIViewController *> *)sd_popToRootViewControllerAnimated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        sdPopDisplayCount = 0;
    }];
    
    [CATransaction setAnimationDuration:sdPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self sd_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return vcs;
}

// change navigationBar barTintColor smooth before pop to current VC finished
- (void)popNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        sdPopDisplayCount += 1;
        
        CGFloat popProgress = [self sdPopProgress];
        
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}

- (void)sd_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        sdPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    
    [CATransaction setAnimationDuration:sdPushDuration];
    [CATransaction begin];
    [self sd_pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// change navigationBar barTintColor smooth before push to current VC finished or before pop to current VC finished
- (void)pushNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        sdPushDisplayCount += 1;
        
        CGFloat pushProgress = [self sdPushProgress];
        
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}

#pragma mark - deal the gesture of return
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    __weak typeof (self) weakSelf = self;
    
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    
    if ([coor initiallyInteractive] == YES) {
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        
        if ([sysVersion floatValue] >= 10) {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        } else {
            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        return YES;
    }
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVC animated:YES];
    return YES;
}

// deal the gesture of return break off
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context {
    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key){
        UIColor *curColor = [[context viewControllerForKey:key] sd_navBarBarTintColor];
        CGFloat curAlpha = [[context viewControllerForKey:key] sd_navBarBackgroundAlpha];
        [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
    };
    
    // after that, cancel the gesture of return
    if ([context isCancelled] == YES) {
        double cancelDuration = [context transitionDuration] * [context percentComplete];
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    } else {
        // after that, finish the gesture of return
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}

- (void)sd_updateInteractiveTransition:(CGFloat)percentComplete {
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    
    [self sd_updateInteractiveTransition:percentComplete];
}

@end


#pragma mark - UIViewController
@implementation UIViewController (SDNavigationBar)

static char SDPushToCurrentVCFinishedKey;
static char SDPushToNextVCFinishedKey;
static char SDNavBarBarTintColorKey;
static char SDNavBarBackgroundAlphaKey;
static char SDNavBarTintColorKey;
static char SDNavBarTitleColorKey;
static char SDStatusBarStyleKey;
static char SDCustomNavBarKey;

// navigationBar barTintColor can not change by currentVC before fromVC push to currentVC finished
- (BOOL)pushToCurrentVCFinished {
    id isFinished = objc_getAssociatedObject(self, &SDPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}

- (void)setPushToCurrentVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &SDPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar barTintColor can not change by currentVC when currentVC push to nextVC finished
- (BOOL)pushToNextVCFinished {
    id isFinished = objc_getAssociatedObject(self, &SDPushToNextVCFinishedKey);
    
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}

- (void)setPushToNextVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &SDPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar barTintColor
- (UIColor *)sd_navBarBarTintColor {
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &SDNavBarBarTintColorKey);
    
    return (barTintColor != nil) ? barTintColor : [UIColor defaultNavBarBarTintColor];
}

- (void)sd_setNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &SDNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([[self sd_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        UINavigationBar *navBar = (UINavigationBar *)[self sd_customNavBar];
        [navBar sd_setBackgroundColor:color];
    } else {
        if ([self pushToCurrentVCFinished] == YES && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
        }
    }
}

// navigationBar _UIBarBackground alpha
- (CGFloat)sd_navBarBackgroundAlpha {
    id barBackgroundAlpha = objc_getAssociatedObject(self, &SDNavBarBackgroundAlphaKey);
    
    return (barBackgroundAlpha != nil) ? [barBackgroundAlpha floatValue] : [UIColor defaultNavBarBackgroundAlpha];
    
}

- (void)sd_setNavBarBackgroundAlpha:(CGFloat)alpha {
    objc_setAssociatedObject(self, &SDNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([[self sd_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        UINavigationBar *navBar = (UINavigationBar *)[self sd_customNavBar];
        [navBar sd_setBackgroundAlpha:alpha];
    } else {
        if ([self pushToCurrentVCFinished] == YES && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
        }
    }
}

// navigationBar tintColor
- (UIColor *)sd_navBarTintColor {
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &SDNavBarTintColorKey);
    
    return (tintColor != nil) ? tintColor : [UIColor defaultNavBarTintColor];
}

- (void)sd_setNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &SDNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([[self sd_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        UINavigationBar *navBar = (UINavigationBar *)[self sd_customNavBar];
        navBar.tintColor = color;
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:color];
        }
    }
}

// navigationBar titleColor
- (UIColor *)sd_navBarTitleColor {
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &SDNavBarTitleColorKey);
    
    return (titleColor != nil) ? titleColor : [UIColor defaultNavBarTitleColor];
}

- (void)sd_setNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &SDNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([[self sd_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        UINavigationBar *navBar = (UINavigationBar *)[self sd_customNavBar];
        navBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:color];
        }
    }
}

// statusBarStyle
- (UIStatusBarStyle)sd_statusBarStyle {
    id style = objc_getAssociatedObject(self, &SDStatusBarStyleKey);
    
    return (style != nil) ? [style integerValue] : [UIColor defaultStatusBarStyle];
}

- (void)sd_setStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &SDStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setNeedsStatusBarAppearanceUpdate];
}

// custom navigationBar
- (UIView *)sd_customNavBar {
    UIView *navBar = objc_getAssociatedObject(self, &SDCustomNavBarKey);
    
    return (navBar != nil) ? navBar : [UIView new];
}

- (void)sd_setCustomNavBar:(UINavigationBar *)navBar {
    objc_setAssociatedObject(self, &SDCustomNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^ {
        SEL needSwizzleSelectors[3] = {
            @selector(viewWillAppear:),
            @selector(viewWillDisappear:),
            @selector(viewDidAppear:)
        };
        
        for (int i = 0; i < 3;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"sd_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)sd_viewWillAppear:(BOOL)animated {
    [self setPushToNextVCFinished:NO];
    [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self sd_navBarTintColor]];
    [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self sd_navBarTitleColor]];
    [self sd_viewWillAppear:animated];
}

- (void)sd_viewWillDisappear:(BOOL)animated {
    [self setPushToNextVCFinished:YES];
    [self sd_viewWillDisappear:animated];
}

- (void)sd_viewDidAppear:(BOOL)animated {
    [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self sd_navBarBarTintColor]];
    
    [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self sd_navBarBackgroundAlpha]];
    
    [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self sd_navBarTintColor]];
    
    [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self sd_navBarTitleColor]];
    
    [self sd_viewDidAppear:animated];
}

@end
