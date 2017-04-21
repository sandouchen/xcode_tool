//
//  SDRecommendLeftModel.m
//  Category
//
//  Created by fqq3 on 17/4/14.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDRecommendLeftModel.h"

@implementation SDRecommendLeftModel
- (NSMutableArray *)users {
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
