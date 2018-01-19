//
//  UINavigationItem+SDExtend.m
//  Category
//
//  Created by fqq3 on 2017/8/31.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "UINavigationItem+SDExtend.h"
#import <objc/runtime.h>

static void *SDLoaderPositionAssociationKey = &SDLoaderPositionAssociationKey;
static void *SDSubstitutedViewAssociationKey = &SDSubstitutedViewAssociationKey;

@implementation UINavigationItem (SDExtend)
- (void)startAnimatingAt:(SDNavBarLoaderPosition)position withActivityIndicatorViewColor:(UIColor *)color {
    // stop previous if animated
    [self stopAnimating];
    
    // hold reference for position to stop at the right place
    objc_setAssociatedObject(self, SDLoaderPositionAssociationKey, @(position), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIActivityIndicatorView *loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    if (color != nil) {
        loader.color = color;
    }
    
    // substitute bar views to loader and hold reference to them for restoration
    switch (position) {
        case SDNavBarLoaderPositionLeft:
            objc_setAssociatedObject(self, SDSubstitutedViewAssociationKey, self.leftBarButtonItem.customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.leftBarButtonItem.customView = loader;
            break;
            
        case SDNavBarLoaderPositionCenter:
            objc_setAssociatedObject(self, SDSubstitutedViewAssociationKey, self.titleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.titleView = loader;
            break;
            
        case SDNavBarLoaderPositionRight:
            objc_setAssociatedObject(self, SDSubstitutedViewAssociationKey, self.rightBarButtonItem.customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.rightBarButtonItem.customView = loader;
            break;
    }
    
    [loader startAnimating];
}

- (void)stopAnimating {
    NSNumber *positionToRestore = objc_getAssociatedObject(self, SDLoaderPositionAssociationKey);
    id componentToRestore = objc_getAssociatedObject(self, SDSubstitutedViewAssociationKey);
    
    // restore UI if animation was in a progress
    if (positionToRestore) {
        switch (positionToRestore.intValue) {
            case SDNavBarLoaderPositionLeft:
                self.leftBarButtonItem.customView = componentToRestore;
                break;
                
            case SDNavBarLoaderPositionCenter:
                self.titleView = componentToRestore;
                break;
                
            case SDNavBarLoaderPositionRight:
                self.rightBarButtonItem.customView = componentToRestore;
                break;
        }
    }
    
    objc_setAssociatedObject(self, SDLoaderPositionAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, SDSubstitutedViewAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
