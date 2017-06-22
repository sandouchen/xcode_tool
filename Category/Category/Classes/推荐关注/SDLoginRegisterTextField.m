//
//  SDLoginRegisterTextField.m
//  Category
//
//  Created by fqq3 on 17/6/14.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDLoginRegisterTextField.h"

@implementation SDLoginRegisterTextField
- (void)awakeFromNib {
    [super awakeFromNib];
    self.tintColor = [UIColor whiteColor];
    [self setPlacerholderColor:[UIColor grayColor]];
}

- (BOOL)becomeFirstResponder {
    [self setPlacerholderColor:[UIColor whiteColor]];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    [self setPlacerholderColor:[UIColor grayColor]];
    return [super resignFirstResponder];
}

- (void)setPlacerholderColor:(UIColor *)color {
    [self setValue:color forKeyPath:SDPlacerholderColor];
}

@end
