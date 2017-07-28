//
//  UIView+SDExtend.h
//  Category
//
//  Created by fqq3 on 17/2/24.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

float radiansForDegrees(int degrees);

@interface UIView (SDExtend)
/** 控件头部位置*/
@property (nonatomic, assign) CGFloat sd_top;
/** 控件左边位置*/
@property (nonatomic, assign) CGFloat sd_left;
/** 控件底部位置*/
@property (nonatomic, assign) CGFloat sd_bottom;
/** 控件右边位置*/
@property (nonatomic, assign) CGFloat sd_right;
/** 控件宽度*/
@property (nonatomic, assign) CGFloat sd_width;
/** 控件高度*/
@property (nonatomic, assign) CGFloat sd_height;
/** 控件X轴中点位置*/
@property (nonatomic, assign) CGFloat sd_centerX;
/** 控件Y轴中点位置*/
@property (nonatomic, assign) CGFloat sd_centerY;
/** 控件点的位置*/
@property (nonatomic, assign) CGPoint sd_origin;
/** 控件的尺寸*/
@property (nonatomic, assign) CGSize  sd_size;
/** 控件圆角 */
@property (nonatomic, assign) CGFloat sd_radius;


/** 自动从xib创建视图 */
+ (instancetype)sd_viewFromXib;

/** 判断一个控件是否真正显示在主窗口 */
- (BOOL)isShowingOnKeyWindow;

/** 移除对应的view */
- (void)sd_removeClassView:(Class)classV;

/** 控件添加阴影 */
- (void)sd_addShadowWithOpacity:(CGFloat)opacity;

/** 添加边框&颜色:四边 */
- (void)sd_setBorder:(UIColor *)color width:(CGFloat)width;


//***************************UIView 动画*********************************
/**
 *   位移
 */
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;

/**
 *   位移
 */
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;

/**
 *   位移
 */
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;

/**
 *   位移
 */
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

/**
 *   旋转
 */
- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;

/**
 *  缩放
 */
- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;

/**
 *  顺时针旋转
 *
 *  @param secs 动画执行时间
 */
- (void)spinClockwise:(float)secs;

/**
 *  逆时针旋转
 *
 *  @param secs 动画执行时间
 */
- (void)spinCounterClockwise:(float)secs;

/**
 *  顺时针旋转一次
 *
 *  @param secs 动画执行时间
 */
- (void)spinClockwiseOnce:(float)secs;

/**
 *  逆时针旋转一次
 *
 *  @param secs 动画执行时间
 */
- (void)spinCounterClockwiseOnce:(float)secs;

/**
 *  反翻页效果
 *
 *  @param secs 动画执行时间
 */
- (void)curlDown:(float)secs;

/**
 *  视图翻页后消失
 *
 *  @param secs 动画执行时间
 */
- (void)curlUpAndAway:(float)secs;

/**
 *  旋转缩放到一点后消失
 *
 *  @param secs 动画执行时间
 */
- (void)drainAway:(float)secs;

/**
 *  将视图改变到一定透明度
 *
 *  @param newAlpha alpha
 *  @param secs     动画执行时间
 */
- (void)changeAlpha:(float)newAlpha secs:(float)secs;


/**
 *  改变透明度结束动画后还原(闪烁动画)
 *
 *  @param secs         alpha
 *  @param continuously 是否循环
 */
- (void)pulse:(float)secs continuously:(BOOL)continuously;


/**
 *  以渐变方式添加子控件
 *
 *  @param subview 需要添加的子控件
 */
- (void)addSubviewWithFadeAnimation:(UIView *)subview;


/**
 淡入动画

 @param time 持续时间
 @param alpha 透明度
 */
- (void)fadeInWithTime:(NSTimeInterval)time withAlpha:(CGFloat)alpha;

/**
 淡入动画

 @param time 持续时间
 */
- (void)fadeInWithTime:(NSTimeInterval)time;


/**
 淡出动画

 @param time 持续时间
 @param alpha 透明度
 */
- (void)fadeOutWithTime:(NSTimeInterval)time withAlpha:(CGFloat)alpha;

/**
 淡出动画

 @param time 持续时间
 */
- (void)fadeOutWithTime:(NSTimeInterval)time;

/**
 缩放

 @param time 持续时间
 @param scal 缩放比例
 */
- (void)scalingWithTime:(NSTimeInterval)time andscal:(CGFloat)scal;

/**
 旋转

 @param time 持续时间
 @param angle 旋转方向
 */
- (void)RevolvingWithTime:(NSTimeInterval)time andDelta:(CGFloat)angle;

@end





