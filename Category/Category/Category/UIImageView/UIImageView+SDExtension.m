//
//  UIImageView+SDExtension.m
//  Category
//
//  Created by fqq3 on 17/5/17.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "UIImageView+SDExtension.h"

@implementation UIImageView (SDExtension)
/**
 设置头像专用
 
 @param imageURL 图片地址
 @param placeholder 占位图片
 */
- (void)sd_setHeaderViewWithURL:(NSString *)imageURL placeholder:(NSString *)placeholder {
    UIImage *placeholderImage = [[UIImage imageNamed:placeholder] sd_circleImage];
    
    [self sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.image = image ? [image sd_circleImage] : placeholderImage;
    }];
}
@end
