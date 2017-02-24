//
//  UIView+SDExtend.h
//  Category
//
//  Created by fqq3 on 17/2/24.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SDExtend)
/** 控件头部位置*/
@property(nonatomic, assign) CGFloat sd_top;
/** 控件左边位置*/
@property(nonatomic, assign) CGFloat sd_left;
/** 控件底部位置*/
@property(nonatomic, assign) CGFloat sd_bottom;
/** 控件右边位置*/
@property(nonatomic, assign) CGFloat sd_right;
/** 控件宽度*/
@property(nonatomic, assign) CGFloat sd_width;
/** 控件高度*/
@property(nonatomic, assign) CGFloat sd_height;
/** 控件X轴中点位置*/
@property(nonatomic, assign) CGFloat sd_centerX;
/** 控件Y轴中点位置*/
@property(nonatomic, assign) CGFloat sd_centerY;
/** 控件点的位置*/
@property(nonatomic, assign) CGPoint sd_origin;
/** 控件的尺寸*/
@property(nonatomic, assign) CGSize  sd_size;
/** 控件圆角 */
@property (nonatomic, assign) CGFloat sd_radius;


/** 自动从xib创建视图 */
+ (instancetype)viewFromXib;

/**
 *  添加边框&颜色:四边
 */
- (void)setBorder:(UIColor *)color width:(CGFloat)width;
@end
