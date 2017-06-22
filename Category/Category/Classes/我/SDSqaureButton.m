//
//  SDSqaureButton.m
//  Category
//
//  Created by fqq3 on 17/5/19.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDSqaureButton.h"
#import "SDSquare.h"

@implementation SDSqaureButton
- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.sd_top = self.sd_height * 0.15f;
    self.imageView.sd_width = self.sd_width * 0.5f;
    self.imageView.sd_height = self.imageView.sd_width;
    self.imageView.sd_centerX = self.sd_width * 0.5;
    
    
    self.titleLabel.sd_left = 0;
    self.titleLabel.sd_top = self.imageView.sd_bottom;
    self.titleLabel.sd_width = self.sd_width;
    self.titleLabel.sd_height = self.sd_height - self.imageView.sd_bottom;
}

- (void)setSquare:(SDSquare *)square {
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    // 利用SDWebImage给按钮设置image
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}
@end
