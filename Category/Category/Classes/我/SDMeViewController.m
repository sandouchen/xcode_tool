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
    
    UIBarButtonItem *moon = [UIBarButtonItem sd_itemWithTarget:self action:@selector(night:) image:@"mine-moon-icon" selectedImage:@"mine-moon-icon-click" insets:0];
    
    self.navigationItem.rightBarButtonItems = @[setting, moon];
    
    self.tableView.tableFooterView = [[SDMeFooterView alloc] init];
}

- (void)settingClick {
    SDSettingViewController *settingVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SDSettingViewController class])];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)night:(UIButton *)item {
    item.selected = !item.selected;
    
    if (item.isSelected) {
        [self.navigationController.view makeToast:@"开启夜间模式" duration:1.0f position:CSToastPositionTop];
    } else {
        [self.navigationController.view makeToast:@"关闭夜间模式" duration:1.0f position:CSToastPositionTop];
    }
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath == [NSIndexPath indexPathForRow:0 inSection:0]) {
        SDLog(@"loging.......");
    } else if (indexPath == [NSIndexPath indexPathForRow:0 inSection:1]) {
        SDLog(@"download.......");
    }
    
}


@end
