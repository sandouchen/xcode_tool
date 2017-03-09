//
//  CALayer+SDExtend.m
//  Category
//
//  Created by fqq3 on 17/3/6.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "CALayer+SDExtend.h"

@implementation CALayer (SDExtend)
/**
 颤抖效果
 
 @param type 颤抖方向
 @return 颤抖控件
 */
- (CAAnimation *)sd_shakeFunctionWithType:(ShakeDirection)type {
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    if (ShakeDirectionUpAndDown == type) shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, -5.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, 5.0f, 0.0f)]];
    
    if (ShakeDirectionLeftAndRight == type) shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    
    shake.autoreverses = YES;
    shake.repeatCount = 2.0f;
    shake.duration = 0.07f;
    [self addAnimation:shake forKey:nil];
    return shake;
}

/**
 3D翻转动画
 
 @param direction 翻转方向
 @param duration 动画持续时间
 @param repeatCount 动画次数
 @return 返回动画效果
 */
- (CAAnimation *)sd_rotatAnimWithDirection:(RotatAnimWithDirection)direction duration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount {
    NSString *key = @"reversAnim";
    
    if ([self animationForKey:key] != nil)  [self removeAnimationForKey:key];
    
    NSString *directionStr = nil;
    
    if (RotatAnimWithDirectionX == direction) directionStr = @"x";
    if (RotatAnimWithDirectionY == direction) directionStr = @"y";
    if (RotatAnimWithDirectionZ == direction) directionStr = @"z";
    
    //创建普通动画
    CABasicAnimation *reversAnim = [CABasicAnimation animationWithKeyPath:[NSString stringWithFormat:@"transform.rotation.%@", directionStr]];
    
    //起点值
    reversAnim.fromValue = @(0);
    //终点值
    reversAnim.toValue = @(M_PI_2);
    //时长
    reversAnim.duration = duration;
    //自动反转
    reversAnim.autoreverses = YES;
    //完成删除
    reversAnim.removedOnCompletion = YES;
    //重复次数
    reversAnim.repeatCount = repeatCount;
    //添加
    [self addAnimation:reversAnim forKey:key];
    
    return reversAnim;
}















@end
