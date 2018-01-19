//
//  SDRefreshFooter.m
//  Category
//
//  Created by fqq3 on 2017/7/14.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDRefreshFooter.h"

@implementation SDRefreshFooter
- (void)prepare {
    [super prepare];
    self.backgroundColor = [UIColor yellowColor];
    
    self.stateLabel.textColor = [UIColor blueColor];
    
    [self setTitle:@"没有更多的数据了" forState:MJRefreshStateNoMoreData];
    [self setTitle:@"上拉或点击有惊喜" forState:MJRefreshStateIdle];
    [self setTitle:@"惊喜正在刷新" forState:MJRefreshStateRefreshing];
    
    // 刷新控件出现一半就会进入刷新状态
    self.triggerAutomaticallyRefreshPercent = 1;
    
    // 不要自动刷新
    self.automaticallyRefresh = NO;
    
    // 隐藏刷新状态的文字
    self.refreshingTitleHidden = NO;
    
}

@end
