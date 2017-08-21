//
//  UIView+SDExtend.m
//  Category
//
//  Created by fqq3 on 17/2/24.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "UIView+SDExtend.h"

float radiansForDegrees(int degrees) {
    return degrees * M_PI / 180;
}

@implementation UIView (SDExtend)
- (CGFloat)sd_top {
    return self.frame.origin.y;
}

- (void)setSd_top:(CGFloat)sd_top {
    CGRect frame = self.frame;
    frame.origin.y = sd_top;
    self.frame = frame;
}

- (CGFloat)sd_left {
    return self.frame.origin.x;
}

- (void)setSd_left:(CGFloat)sd_left {
    CGRect frame = self.frame;
    frame.origin.x = sd_left;
    self.frame = frame;
}

- (CGFloat)sd_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSd_bottom:(CGFloat)sd_bottom {
    CGRect frame = self.frame;
    frame.origin.y = sd_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)sd_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSd_right:(CGFloat)sd_right {
    CGRect frame = self.frame;
    frame.origin.x = sd_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)sd_width {
    return self.frame.size.width;
}

- (void)setSd_width:(CGFloat)sd_width {
    CGRect frame = self.frame;
    frame.size.width = sd_width;
    self.frame = frame;
}

- (CGFloat)sd_height {
    return self.frame.size.height;
}

- (void)setSd_height:(CGFloat)sd_height {
    CGRect frame = self.frame;
    frame.size.height = sd_height;
    self.frame = frame;
}

- (CGFloat)sd_centerX {
    return self.center.x;
}

- (void)setSd_centerX:(CGFloat)sd_centerX {
    self.center = CGPointMake(sd_centerX, self.center.y);
}

- (CGFloat)sd_centerY {
    return self.center.y;
}

- (void)setSd_centerY:(CGFloat)sd_centerY {
    self.center = CGPointMake(self.center.x, sd_centerY);
}

- (CGPoint)sd_origin {
    return self.frame.origin;
}

- (void)setSd_origin:(CGPoint)sd_origin {
    CGRect frame = self.frame;
    frame.origin = sd_origin;
    self.frame = frame;
}

- (CGSize)sd_size {
    return self.frame.size;
}

- (void)setSd_size:(CGSize)sd_size {
    CGRect frame = self.frame;
    frame.size = sd_size;
    self.frame = frame;
}

- (void)setSd_radius:(CGFloat)sd_radius {
    if(sd_radius <= 0) sd_radius = self.frame.size.width * .5f;
    
    //圆角半径
    self.layer.cornerRadius = sd_radius;
    
    //强制
    self.layer.masksToBounds = YES;
}

- (CGFloat)sd_radius {
    return 0;
}

/**
 *  @brief  找到当前view所在的viewcontroler
 */
- (UIViewController *)currentViewController {
    UIResponder *responder = self.nextResponder;
    
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        
        responder = responder.nextResponder;
        
    } while (responder);
    
    return nil;
}

/** 判断一个控件是否真正显示在主窗口 */
- (BOOL)isShowingOnKeyWindow {
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

/** 自动从xib创建视图 */
+ (instancetype)sd_viewFromXib {
    NSString *name = NSStringFromClass(self);
    
    UIView *xibView = [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];
    
    if(xibView == nil){
        SDLog(@"CoreXibView：从xib创建视图失败，当前类是：%@",name);
    }
    
    return xibView;
}

/** 移除对应的view */
- (void)sd_removeClassView:(Class)classV {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:classV]) {
            [view removeFromSuperview];
        }
    }
}

/** 控件添加阴影 */
- (void)sd_addShadowWithOpacity:(CGFloat)opacity {
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = opacity;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.sd_height - 2, self.sd_width == 320 ? [UIScreen mainScreen].bounds.size.width : self.sd_width, 2)].CGPath;
}

/**
 *  添加边框&颜色:四边
 */
-(void)sd_setBorder:(UIColor *)color width:(CGFloat)width {
    CALayer *layer = self.layer;
    layer.borderColor = color.CGColor;
    layer.borderWidth = width;
}


// *************** UIView 动画 ***************
#pragma mark - Moves
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option {
    [self moveTo:destination duration:secs option:option delegate:nil callback:nil];
}

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.frame = CGRectMake(destination.x,destination.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [delegate performSelector:method];
#pragma clang diagnostic pop
                             
                         }
                     }];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack {
    [self raceTo:destination withSnapBack:withSnapBack delegate:nil callback:nil];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method {
    CGPoint stopPoint = destination;
    if (withSnapBack) {
        // Determine our stop point, from which we will "snap back" to the final destination
        int diffx = destination.x - self.frame.origin.x;
        int diffy = destination.y - self.frame.origin.y;
        if (diffx < 0) {
            // Destination is to the left of current position
            stopPoint.x -= 10.0;
        } else if (diffx > 0) {
            stopPoint.x += 10.0;
        }
        if (diffy < 0) {
            // Destination is to the left of current position
            stopPoint.y -= 10.0;
        } else if (diffy > 0) {
            stopPoint.y += 10.0;
        }
    }
    
    // Do the animation
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.frame = CGRectMake(stopPoint.x, stopPoint.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (withSnapBack) {
                             [UIView animateWithDuration:0.1
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.frame = CGRectMake(destination.x, destination.y, self.frame.size.width, self.frame.size.height);
                                              }
                                              completion:^(BOOL finished) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                                                  [delegate performSelector:method];
#pragma clang diagnostic pop
                                                  
                                              }];
                         } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [delegate performSelector:method];
#pragma clang diagnostic pop
                         }
                     }];
}

#pragma mark - Transforms
- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(degrees));
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [delegate performSelector:method];
#pragma clang diagnostic pop
                         }
                     }];
}

- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformScale(self.transform, scaleX, scaleY);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             [delegate performSelector:method];
#pragma clang diagnostic pop
                         }
                     }];
}

- (void)spinClockwise:(float)secs {
    [UIView animateWithDuration:secs/4
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(90));
                     }
                     completion:^(BOOL finished) {
                         [self spinClockwise:secs];
                     }];
}

- (void)spinCounterClockwise:(float)secs {
    [UIView animateWithDuration:secs/4
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(270));
                     }
                     completion:^(BOOL finished) {
                         [self spinCounterClockwise:secs];
                     }];
}

- (void)spinClockwiseOnce:(float)secs {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = secs;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1.0;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)spinCounterClockwiseOnce:(float)secs {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: -(M_PI * 2.0)];
    rotationAnimation.duration = secs;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1.0;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark - Transitions
- (void)curlDown:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^ { [self setAlpha:1.0]; }
                    completion:nil];
}

- (void)curlUpAndAway:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { [self setAlpha:0]; }
                    completion:nil];
}

- (void)drainAway:(float)secs {
    self.tag = 20;
    [NSTimer scheduledTimerWithTimeInterval:secs/50 target:self selector:@selector(drainTimer:) userInfo:nil repeats:YES];
}

- (void)drainTimer:(NSTimer*)timer {
    CGAffineTransform trans = CGAffineTransformRotate(CGAffineTransformScale(self.transform, 0.9, 0.9),0.314);
    self.transform = trans;
    self.alpha = self.alpha * 0.98;
    self.tag = self.tag - 1;
    if (self.tag <= 0) {
        [timer invalidate];
        [self removeFromSuperview];
    }
}

#pragma mark - Effects
- (void)changeAlpha:(float)newAlpha secs:(float)secs {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = newAlpha;
                     }
                     completion:nil];
}

- (void)pulse:(float)secs continuously:(BOOL)continuously {
    [UIView animateWithDuration:secs/2
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         // Fade out, but not completely
                         self.alpha = 0.3;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:secs/2
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              // Fade in
                                              self.alpha = 1.0;
                                          }
                                          completion:^(BOOL finished) {
                                              if (continuously) {
                                                  [self pulse:secs continuously:continuously];
                                              }
                                          }];
                     }];
}

#pragma mark - add subview
- (void)addSubviewWithFadeAnimation:(UIView *)subview {
    
    CGFloat finalAlpha = subview.alpha;
    
    subview.alpha = 0.0;
    [self addSubview:subview];
    [UIView animateWithDuration:0.2 animations:^{
        subview.alpha = finalAlpha;
    }];
}

// 淡入
- (void)fadeInWithTime:(NSTimeInterval)time withAlpha:(CGFloat)alpha {
    self.alpha = 0;
    [UIView animateWithDuration:time animations:^{
        self.alpha = alpha;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)fadeInWithTime:(NSTimeInterval)time {
    self.alpha = 0;
    [UIView animateWithDuration:time animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

// 淡出
- (void)fadeOutWithTime:(NSTimeInterval)time withAlpha:(CGFloat)alpha {
    self.alpha = alpha;
    [UIView animateWithDuration:time animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)fadeOutWithTime:(NSTimeInterval)time {
    self.alpha = 1;
    [UIView animateWithDuration:time animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// 缩放
- (void)scalingWithTime:(NSTimeInterval)time andscal:(CGFloat)scal {
    
    [UIView animateWithDuration:time animations:^{
        self.transform = CGAffineTransformMakeScale(scal,scal);
    }];
}

// 旋转
- (void)RevolvingWithTime:(NSTimeInterval)time andDelta:(CGFloat)angle {
    [UIView animateWithDuration:time animations:^{
        self.transform = CGAffineTransformMakeRotation(angle);
    }];
}

@end
