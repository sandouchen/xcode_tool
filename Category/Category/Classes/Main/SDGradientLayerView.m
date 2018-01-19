//
//  SDGradientLayerView.m
//  Category
//
//  Created by fqq3 on 2017/9/13.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDGradientLayerView.h"

@implementation SDGradientLayerView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor];
        gradientLayer.locations = @[@0, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = self.bounds;
        [self.layer addSublayer:gradientLayer];
    }
    
    return self;
}

@end
