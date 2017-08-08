//
//  AppDelegate.m
//  Category
//
//  Created by fqq3 on 17/2/23.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self monitorNetworkStatus];
    [[UIButton appearance] setExclusiveTouch:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:(UIStatusBarAnimationSlide)];
    return YES;
}

#pragma mark - 实时监测网络状态
- (void)monitorNetworkStatus {
    [SDNetworkHelper networkStatusWithBlock:^(SDNetworkStatusType status) {
        switch (status) {
            case SDNetworkStatusUnknown:
                ALERTVIEW(@"未知名网络,请注意!!!");
                break;
                
            case SDNetworkStatusNotReachable:
                ALERTVIEW(@"断网了,请注意!!!");
                break;
                
            case SDNetworkStatusReachableViaWiFi:
                NSLog(@"已连接WIFI,可以使劲用!!!");
                break;
                
            case SDNetworkStatusReachableViaWWAN:
                ALERTVIEW(@"手机4G网络,省着点用!!!");
                break;
                
            default:
                break;
        }
    }];
}

@end
