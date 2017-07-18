//
//  SDRefreshGifHeader.m
//  Category
//
//  Created by fqq3 on 2017/7/14.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDRefreshGifHeader.h"

@interface SDRefreshGifHeader ()
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UIImageView *backgroundImage;
@end

@implementation SDRefreshGifHeader
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
    
    self.automaticallyChangeAlpha = YES;
    
    self.lastUpdatedTimeLabel.textColor = [UIColor redColor];
    self.lastUpdatedTimeLabel.hidden = NO;
    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:15];
    
    self.stateLabel.textColor = [UIColor greenColor];
    self.stateLabel.hidden = NO;
    self.stateLabel.font = [UIFont systemFontOfSize:20];
    
    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
    
    self.backgroundColor = [UIColor yellowColor];
    
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
    
    self.logo.sd_centerX = self.sd_centerX;
    self.logo.sd_bottom = self.sd_bottom - 10;
}

@end
