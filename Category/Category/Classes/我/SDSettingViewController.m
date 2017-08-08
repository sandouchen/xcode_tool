
//
//  SDSettingViewController.m
//  Category
//
//  Created by fqq3 on 17/5/27.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDSettingViewController.h"
#import <SDWebImage/SDImageCache.h>
#import "SDClearCache.h"

@interface SDSettingViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *fontSegment;
@property (weak, nonatomic) IBOutlet UISwitch *forwardingSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *moonSwitch;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (nonatomic, assign) NSInteger totalSize;
@end

@implementation SDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.versionLabel.text = CURRENTVERSION;
}

- (IBAction)segmentAction:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            NSLog(@"选择 小");
            break;
        case 1:
            NSLog(@"选择 中");
            break;
        case 2:
            NSLog(@"选择 大");
            break;
            
        default:
            break;
    }
}

- (IBAction)forwardingSwitchAction:(UISwitch *)sender {
    if (sender.isOn) {
        [sender setOn:YES animated:YES];
        NSLog(@"选择 YES");
    } else {
        [sender setOn:NO animated:YES];
        NSLog(@"选择 NO");
    }
}

- (IBAction)moonSwitchAction:(UISwitch *)sender {
    if (sender.isOn) {
        [sender setOn:YES animated:YES];
        NSLog(@"夜间");
    } else {
        [sender setOn:NO animated:YES];
        NSLog(@"白天");
    }
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setFont:[UIFont systemFontOfSize:18]];
    [header.textLabel setTextColor:[UIColor grayColor]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath == [NSIndexPath indexPathForRow:0 inSection:1]) {
        NSLog(@"离线下载");
        
    } else if (indexPath == [NSIndexPath indexPathForRow:2 inSection:1]) {
        NSLog(@"当前版本");
        
    } else if (indexPath == [NSIndexPath indexPathForRow:3 inSection:1]) {
        NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1093382986&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"];
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        } else {
            NSLog(@"can not open");
        }
    } else if (indexPath == [NSIndexPath indexPathForRow:4 inSection:1]) {
        // A跳转到应用B,项目App-B -> TARGETS -> Info -> URL Types -> URL Schemes，设置App-B的URL Schemes为AppB
        
        // 如果是iOS9之后的模拟器或是真机,在App-A的Info文件中，添加LSApplicationQueriesSchemes数组，然后添加键值为AppB的字符串
        
        // 1.获取应用程序App-B的URL Scheme
        NSURL *url = [NSURL URLWithString:@"BuDeJie://setting"];
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            // 3. 打开应用程序App-B
            [[UIApplication sharedApplication] openURL:url];
        } else {
            NSLog(@"can not open");
        }
    }
}

@end
