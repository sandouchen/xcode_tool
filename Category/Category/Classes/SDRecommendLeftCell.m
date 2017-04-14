//
//  SDRecommendLeftCell.m
//  Category
//
//  Created by fqq3 on 17/4/14.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDRecommendLeftCell.h"
#import "SDRecommendLeftModel.h"

@interface SDRecommendLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UIView *leftView;

@end

@implementation SDRecommendLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.leftView.hidden = !selected;
    self.nameLb.textColor = selected ? [UIColor redColor] : [UIColor blackColor];
}

- (void)setRecommendLeftModel:(SDRecommendLeftModel *)recommendLeftModel {
    _recommendLeftModel = recommendLeftModel;
    
    self.nameLb.text = recommendLeftModel.name;
}

@end
