//
//  SDRefreshAutoGifFooter.m
//  Category
//
//  Created by fqq3 on 2017/7/14.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDRefreshAutoGifFooter.h"

@interface SDRefreshAutoGifFooter ()
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UIImageView *backgroundImage;
@end

@implementation SDRefreshAutoGifFooter
- (void)prepare {
    [super prepare];
    static CGFloat duration = 1.0f;
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    
    for (NSUInteger i = 1; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bdj_mj_refresh_%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages duration:duration forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self setImages:idleImages duration:duration forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages duration:duration forState:MJRefreshStateRefreshing];
    
    self.backgroundColor = [UIColor yellowColor];
    
    self.stateLabel.textColor = [UIColor blueColor];
    
    [self setTitle:@"没有更多的数据了" forState:MJRefreshStateNoMoreData];
    [self setTitle:@"上拉或点击有惊喜" forState:MJRefreshStateIdle];
    [self setTitle:@"惊喜正在刷新" forState:MJRefreshStateRefreshing];
    
    // 不要自动刷新
    self.automaticallyRefresh = YES;
    
    // 隐藏刷新状态的文字
    self.refreshingTitleHidden = NO;
    
    
    self.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    [self addSubview:self.logo];
    
    self.backgroundImage = [[UIImageView alloc] init];
    self.backgroundImage.image = [UIImage imageNamed:@"millcolorGrad"];
    [self insertSubview:self.backgroundImage atIndex:0];
}

- (void)placeSubviews {
    [super placeSubviews];
    self.sd_height = 60;
    
    self.backgroundImage.sd_width = self.sd_width;
    self.backgroundImage.sd_height = self.sd_height;
    self.backgroundImage.sd_left = self.sd_left;
    
    self.logo.center = CGPointMake(self.mj_w * 0.5, self.mj_h + self.logo.mj_h);
}

@end
