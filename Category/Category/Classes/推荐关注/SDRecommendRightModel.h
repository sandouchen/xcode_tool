//
//  SDRecommendRightModel.h
//  Category
//
//  Created by fqq3 on 17/4/17.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDRecommendRightModel : NSObject
@property (copy, nonatomic) NSString *header;

@property (assign, nonatomic) NSInteger uid;

@property (assign, nonatomic) BOOL is_vip;

@property (assign, nonatomic) NSInteger is_follow;

@property (copy, nonatomic) NSString *introduction;

@property (assign, nonatomic) NSInteger fans_count;

@property (assign, nonatomic) NSInteger gender;

@property (assign, nonatomic) NSInteger tiezi_count;

@property (copy, nonatomic) NSString *screen_name;

@end
