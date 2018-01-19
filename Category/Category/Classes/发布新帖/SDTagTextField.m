//
//  SDTagTextField.m
//  Category
//
//  Created by fqq3 on 17/5/25.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDTagTextField.h"

@implementation SDTagTextField
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.returnKeyType = UIReturnKeySend;
        self.placeholder = @"多个标签用逗号或者换行隔开";
        [self setValue:[UIColor redColor] forKeyPath:SDPlacerholderColor];
    }
    
    return self;
}

- (void)deleteBackward {
    !self.deleteBlock ? : self.deleteBlock();
    
    [super deleteBackward];
}
@end
