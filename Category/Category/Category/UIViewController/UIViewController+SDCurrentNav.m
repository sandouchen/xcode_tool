//
//  UIViewController+SDCurrentNav.m
//  Category
//
//  Created by fqq3 on 2017/7/24.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "UIViewController+SDCurrentNav.h"

@implementation UIViewController (SDCurrentNav)
+ (UIViewController *)currentView:(UIView *)view {
    UIResponder *responder = view;
    
    while ((responder = [responder nextResponder]))
        
        if ([responder isKindOfClass: [UIViewController class]])
            
            return (UIViewController *)responder;
    
    return nil;
}
@end
