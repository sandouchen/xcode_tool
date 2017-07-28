//
//  SDUser.h
//  Category
//
//  Created by fqq3 on 17/5/2.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 点赞的人的发帖的数量 */
@property (nonatomic, copy) NSString *tiezi_count;
/** 点赞人的关注了人的总数 */
@property (nonatomic, copy) NSString *follow_count;
@end
