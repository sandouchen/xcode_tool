//
//  UIView+SDExtend.m
//  Category
//
//  Created by fqq3 on 17/2/24.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "UIView+SDExtend.h"

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


/** 自动从xib创建视图 */
+ (instancetype)viewFromXib {
    NSString *name = NSStringFromClass(self);
    
    UIView *xibView = [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];
    
    if(xibView == nil){
        NSLog(@"CoreXibView：从xib创建视图失败，当前类是：%@",name);
    }
    
    return xibView;
}

/**
 *  添加边框&颜色:四边
 */
-(void)setBorder:(UIColor *)color width:(CGFloat)width {
    CALayer *layer = self.layer;
    layer.borderColor = color.CGColor;
    layer.borderWidth = width;
}




@end
