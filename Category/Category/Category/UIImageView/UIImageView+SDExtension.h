//
//  UIImageView+SDExtension.h
//  Category
//
//  Created by fqq3 on 17/5/17.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SDExtension)
/**
 设置头像专用

 @param imageURL 图片地址
 @param placeholder 占位图片
 */
- (void)sd_setHeaderViewWithURL:(NSString *)imageURL placeholder:(NSString *)placeholder;


/**
 图片倒影
 */
- (void)sd_imageViewReflect;

@end
