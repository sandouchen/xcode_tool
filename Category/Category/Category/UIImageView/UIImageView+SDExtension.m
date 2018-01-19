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

/**
 图片倒影
 */
- (void)sd_imageViewReflect {
    CGRect frame = self.frame;
    frame.origin.y += frame.size.height + 1;
    
    UIImageView *reflectionImageView = [[UIImageView alloc] initWithFrame:frame];
    self.clipsToBounds = YES;
    reflectionImageView.contentMode = self.contentMode;
    [reflectionImageView setImage:self.image];
    reflectionImageView.transform = CGAffineTransformMakeScale(1.0, -1.0);
    
    CALayer *reflectionLayer = [reflectionImageView layer];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = reflectionLayer.bounds;
    gradientLayer.position = CGPointMake(reflectionLayer.bounds.size.width / 2, reflectionLayer.bounds.size.height * 0.5);
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[[UIColor clearColor] CGColor],
                            (id)[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] CGColor], nil];
    gradientLayer.startPoint = CGPointMake(0.5, 0.5);
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    reflectionLayer.mask = gradientLayer;
    
    [self.superview addSubview:reflectionImageView];
}


@end
