//
//  SDNewListCell.m
//  Category
//
//  Created by fqq3 on 17/4/19.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDNewListCell.h"
#import "SDNewListModel.h"
#import "SDNavigationController.h"

@interface SDNewListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *numLb;
@property (weak, nonatomic) IBOutlet UIButton *FollowBtn;

@end

@implementation SDNewListCell
- (void)awakeFromNib {
    [super awakeFromNib];
    UIImage *image = [[UIImage sd_imageWithColor:[[UIColor yellowColor] colorWithAlphaComponent:0.5f]] sd_imageWithRoundedCornersAndSize:self.FollowBtn.sd_size andCornerRadius:7];
    [self.FollowBtn setBackgroundImage:image forState:(UIControlStateNormal)];
}

- (IBAction)clickToFollow {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = @"测试 View";
    vc.view.backgroundColor = [UIColor redColor];
    [self.currentViewController.navigationController pushViewController:vc animated:YES];
}

- (void)setListModel:(SDNewListModel *)listModel {
    _listModel = listModel;
    self.nameLb.text = listModel.theme_name;
    
    NSString *subNumber = [NSString stringWithFormat:@"%zd人订阅", listModel.sub_number];
    
    if (listModel.sub_number > 10000) {
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", listModel.sub_number / 10000.0];
        subNumber = [subNumber stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    self.numLb.text = subNumber;
    
    [self.headerImageView sd_setHeaderViewWithURL:listModel.image_list placeholder:@"defaultUserIcon"];
}

@end
