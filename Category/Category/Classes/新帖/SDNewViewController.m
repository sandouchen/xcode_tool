
//
//  SDNewViewController.m
//  Category
//
//  Created by fqq3 on 2017/7/19.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDNewViewController.h"

@interface SDNewViewController ()

@end

@implementation SDNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)toNextVC {
    [MBProgressHUD showWarn:NSLocalizedString(@"建设中...", nil) toView:nil];
}

@end
