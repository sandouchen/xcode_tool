//
//  SDRecommendRightCell.m
//  Category
//
//  Created by fqq3 on 17/4/17.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDRecommendRightCell.h"
#import "SDRecommendRightModel.h"

@interface SDRecommendRightCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@end

@implementation SDRecommendRightCell
- (void)setRightModel:(SDRecommendRightModel *)rightModel {
    _rightModel = rightModel;
    
    self.screenNameLabel.text = rightModel.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", rightModel.fans_count];
    
    [self.headerImageView sd_setHeaderViewWithURL:rightModel.header placeholder:@"defaultUserIcon"];
}

@end
