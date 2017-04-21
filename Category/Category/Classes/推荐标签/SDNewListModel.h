//
//  SDNewListModel.h
//  Category
//
//  Created by fqq3 on 17/4/13.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDNewListModel : NSObject

@property (copy, nonatomic) NSString *image_list;

@property (copy, nonatomic) NSString *theme_id;

@property (copy, nonatomic) NSString *theme_name;

@property (assign, nonatomic) NSInteger is_sub;

@property (assign, nonatomic) NSInteger is_default;

@property (assign, nonatomic) NSInteger sub_number;

@end
