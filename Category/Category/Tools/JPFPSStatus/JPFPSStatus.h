//
//  JPFPSStatus.h
//  JPFPSStatus
//
//  Created by coderyi on 16/6/4.
//  Copyright © 2016年 http://coderyi.com . All rights reserved.
//  @ https://github.com/joggerplus/JPFPSStatus

/**
 #if defined(DEBUG)||defined(_DEBUG)
 [[JPFPSStatus sharedInstance] open];
 #endif
 */

#import <UIKit/UIKit.h>

@interface JPFPSStatus : NSObject

@property (nonatomic,strong)UILabel *fpsLabel;

+ (JPFPSStatus *)sharedInstance;

- (void)open;
- (void)close;
- (void)openWithHandler:(void (^)(NSInteger fpsValue))handler;

@end
