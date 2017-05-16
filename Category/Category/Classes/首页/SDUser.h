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
@end
