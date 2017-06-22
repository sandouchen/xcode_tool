
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
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (nonatomic, assign) NSInteger totalSize;
@end

@implementation SDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.versionLabel.text = CURRENTVERSION;
    
    self.cacheLabel.text = [NSString stringWithFormat:@"清除缓存（%@）", [SDClearCache getCacheSize]];
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
        
    } else if (indexPath == [NSIndexPath indexPathForRow:1 inSection:1]) {
        [SDClearCache clearCache];
        
        self.cacheLabel.text = [NSString stringWithFormat:@"清除缓存（%@）", [SDClearCache getCacheSize]];
        
        [self.tableView reloadData];
        
        ALERTVIEW(@"缓存已清除");
        
    } else if (indexPath == [NSIndexPath indexPathForRow:2 inSection:1]) {
        NSLog(@"当前版本");
    }
}

@end
