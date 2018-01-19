//
//  SDRefreshHeader.m
//  Category
//
//  Created by fqq3 on 2017/7/14.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDRefreshHeader.h"

@implementation SDRefreshHeader
- (void)prepare {
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    
    self.lastUpdatedTimeLabel.textColor = [UIColor redColor];
    
    self.stateLabel.textColor = [UIColor greenColor];
    
    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
}
@end
