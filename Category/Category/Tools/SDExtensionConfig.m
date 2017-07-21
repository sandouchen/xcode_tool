//
//  SDExtensionConfig.m
//  Category
//
//  Created by fqq3 on 17/6/12.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDExtensionConfig.h"
#import "SDTopic.h"

@implementation SDExtensionConfig
+ (void)load {
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id"};
    }];
    
    [SDTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1"
                 };
    }];
    
    /*
    // 服务器返回下划线的属性，统一改驼峰属性
    [NSString mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
        return [propertyName mj_camelFromUnderline];
    }];
    */
}
@end
