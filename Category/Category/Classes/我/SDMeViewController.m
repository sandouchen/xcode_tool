//
//  SDMeViewController.m
//  Category
//
//  Created by fqq3 on 17/5/18.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDMeViewController.h"
#import "SDMeFooterView.h"
#import "SDSettingViewController.h"

@interface SDMeViewController ()

@end

@implementation SDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *setting = [UIBarButtonItem sd_itemWithTarget:self action:@selector(settingClick) image:@"mine-setting-icon" highImage:@"mine-setting-icon-click" insets:0];
    
    UIBarButtonItem *moon = [UIBarButtonItem sd_itemWithTarget:self action:nil image:@"mine-moon-icon" highImage:@"mine-moon-icon-click" insets:0];
    
    self.navigationItem.rightBarButtonItems = @[setting, moon];
    
    self.tableView.tableFooterView = [[SDMeFooterView alloc] init];
}

- (void)settingClick {
    SDSettingViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SDSettingViewController class])];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - Table view data source
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath == [NSIndexPath indexPathForRow:0 inSection:0]) {
        NSLog(@"loging.......");
    } else if (indexPath == [NSIndexPath indexPathForRow:0 inSection:1]) {
        NSLog(@"download.......");
    }
    
}


@end
