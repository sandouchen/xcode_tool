//
//  SDProgressView.m
//  Category
//
//  Created by fqq3 on 2017/7/21.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDProgressView.h"

@implementation SDProgressView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.roundedCorners = 5;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}
@end
