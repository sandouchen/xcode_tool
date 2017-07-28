
//
//  SDCommentSectionHeader.m
//  Category
//
//  Created by fqq3 on 2017/7/21.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDCommentSectionHeader.h"

@interface SDCommentSectionHeader ()
@property (nonatomic, strong) UIView *topLine;
@end

@implementation SDCommentSectionHeader
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.topLine = [[UIView alloc] init];
        self.topLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        [self.contentView addSubview:self.topLine];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.topLine.sd_top = self.contentView.sd_top;
    self.topLine.sd_width = self.contentView.sd_width;
    self.topLine.sd_left = self.contentView.sd_left;
    self.topLine.sd_height = 1;
    
    // 在layoutSubviews方法中覆盖对子控件的一些设置
    self.textLabel.font = [UIFont systemFontOfSize:15];
    
    // 设置label的x值
    self.textLabel.sd_left = SDLayoutMargin_10;
    self.textLabel.sd_bottom = self.contentView.sd_bottom - 3;
    
}
@end
