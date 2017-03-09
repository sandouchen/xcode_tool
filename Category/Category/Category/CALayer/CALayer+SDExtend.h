//
//  CALayer+SDExtend.h
//  Category
//
//  Created by fqq3 on 17/3/6.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

/**
 *  颤抖方向
 */
typedef NS_ENUM(NSInteger, ShakeDirection) {
    // 上下颤抖
    ShakeDirectionUpAndDown = 0,
    // 左右颤抖
    ShakeDirectionLeftAndRight = 1,
};

/**
 *  反转方向
 */
typedef NS_ENUM(NSInteger, RotatAnimWithDirection) {
    // X轴旋转
    RotatAnimWithDirectionX = 0,
    
    // Y轴旋转
    RotatAnimWithDirectionY = 1,
    
    // Z轴旋转
    RotatAnimWithDirectionZ = 2,
};

@interface CALayer (SDExtend)
/**
 颤抖效果
 
 @param type 颤抖方向
 @return 颤抖控件
 */
- (CAAnimation *)sd_shakeFunctionWithType:(ShakeDirection)type;

/**
 3D翻转动画

 @param direction 翻转方向
 @param duration 动画持续时间
 @param repeatCount 动画次数
 @return 返回动画效果
 */
- (CAAnimation *)sd_rotatAnimWithDirection:(RotatAnimWithDirection)direction duration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount;
@end
