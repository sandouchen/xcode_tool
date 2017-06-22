
//
//  SDFriendTrendsViewController.m
//  Category
//
//  Created by fqq3 on 17/6/6.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDFriendTrendsViewController.h"

@interface SDFriendTrendsViewController ()

@end

@implementation SDFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem sd_itemWithTarget:self action:@selector(friendsClick) image:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" insets:1];
}

- (void)friendsClick {
    [self performSegueWithIdentifier:@"toVC" sender:nil];
}

- (IBAction)loginRegister {
    
}

@end
