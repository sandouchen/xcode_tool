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
@property (nonatomic, weak) UIButton *publishButton;
@end

@implementation SDTabBar
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
    
    // 添加发布按钮
    UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    publishButton.sd_size = publishButton.currentBackgroundImage.size;
    [self addSubview:publishButton];
    self.publishButton = publishButton;
}

- (void)publishClick {
//    [[UIApplication sharedApplication].keyWindow.rootViewController performSegueWithIdentifier:@"toPublishVC" sender:nil];
    
    SDPublishView *publishView = [[SDPublishView alloc] initWithFrame:SCREENBOUNDS];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:publishView];
    [publishView fadeInWithTime:0.3f];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 标记按钮是否已经添加过监听器
    static BOOL added = NO;
    
    
    CGFloat width = self.sd_width;
    CGFloat height = self.sd_height;
    
    // 设置发布按钮的frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
        
        if (added == NO) {
            [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
        }
    }
    added = YES;
}

- (void)buttonClick {
    
}



@end
