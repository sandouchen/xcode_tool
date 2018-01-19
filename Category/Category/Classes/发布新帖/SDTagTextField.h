//
//  SDTagTextField.h
//  Category
//
//  Created by fqq3 on 17/5/25.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteBlock)();

@interface SDTagTextField : UITextField

@property (nonatomic, copy) DeleteBlock deleteBlock;

@end
