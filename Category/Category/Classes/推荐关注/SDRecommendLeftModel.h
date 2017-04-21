//
//  SDRecommendLeftModel.h
//  Category
//
//  Created by fqq3 on 17/4/14.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDRecommendLeftModel : NSObject
@property (assign, nonatomic) NSInteger count;

@property (assign, nonatomic) NSInteger ID;

@property (copy, nonatomic) NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger total;

@end
