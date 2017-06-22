//
//  SDNewListCell.m
//  Category
//
//  Created by fqq3 on 17/4/19.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDNewListCell.h"
#import "SDNewListModel.h"

@interface SDNewListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *numLb;

@end

@implementation SDNewListCell
- (void)setListModel:(SDNewListModel *)listModel {
    _listModel = listModel;
    self.nameLb.text = listModel.theme_name;
    
    NSString *subNumber;
    if (listModel.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", listModel.sub_number];
    } else {
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", listModel.sub_number / 10000.0];
    }
    
    self.numLb.text = subNumber;
    
    [self.headerImageView sd_setHeaderViewWithURL:listModel.image_list placeholder:@"defaultUserIcon"];
}

@end
