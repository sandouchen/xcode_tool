//
//  SDTabBar.m
//  Category
//
//  Created by fqq3 on 17/6/6.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDTabBar.h"
#import "SDPublishViewController.h"
#import "SDPublishView.h"

@interface SDTabBar ()
/** 发布按钮 */
@property (nonatomic, strong) UIButton *publishButton;
@end

@implementation SDTabBar
// 添加发布按钮
- (UIButton *)publishButton {
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [_publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_publishButton];
    }
    return _publishButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self initTabBar];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        [self initTabBar];
    }
    return self;
}

- (void)initTabBar {
    // 设置tabbar的背景图片
    [self setBackgroundImage:[UIImage sd_imageWithColor:[UIColor yellowColor]]];
}

- (void)publishClick {
//    [[UIApplication sharedApplication].keyWindow.rootViewController performSegueWithIdentifier:@"toPublishVC" sender:nil];
    
    SDPublishView *publishView = [[SDPublishView alloc] initWithFrame:SCREENBOUNDS];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:publishView];
    [publishView fadeInWithTime:0.2f];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 标记按钮是否已经添加过监听器
    static BOOL added = NO;
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.sd_width / 5;
    CGFloat buttonH = self.sd_height;
    NSInteger index = 0;
    
    // 设置发布按钮的frame
    self.publishButton.sd_size = CGSizeMake(buttonW, buttonH);
    self.publishButton.center = CGPointMake(self.sd_width * 0.5, self.sd_height * 0.5);
    
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
        
        if (added == NO) {
            // 监听按钮点击
            [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
        }
    }
    added = YES;
}

// 连续点击同一个 tabBarItem 刷新当前View
- (void)buttonClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:SDTabBarDidSelectNotification object:nil];
}



@end
