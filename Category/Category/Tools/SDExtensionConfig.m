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
                 @"width" : @"pictureW",
                 @"height" : @"pictureH"
                 };
    }];
    
}
@end
