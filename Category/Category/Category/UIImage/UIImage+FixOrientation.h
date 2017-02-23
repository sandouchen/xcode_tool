//
//  UIImage+FixOrientation.h
//  Category
//
//  Created by fqq3 on 17/2/23.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FixOrientation)
/**
 将图像的原始数据旋转至正确的方向
 */
- (UIImage *)fixOrientation;

@end
