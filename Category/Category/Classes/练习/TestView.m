//
//  TestView.m
//  Category
//
//  Created by fqq3 on 17/2/24.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "TestView.h"

@implementation TestView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self removeFromSuperview];
}
@end
