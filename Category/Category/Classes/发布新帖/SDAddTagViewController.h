//
//  SDAddTagViewController.h
//  Category
//
//  Created by fqq3 on 17/5/24.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDAddTagViewController : UIViewController
@property (nonatomic, copy) void(^tagBlock)(NSArray *tags);
/** 所有的标签 */
@property (nonatomic, strong) NSArray *tags;
@end
