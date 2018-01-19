//
//  SDAddTagToolbar.m
//  Category
//
//  Created by fqq3 on 17/5/24.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDAddTagToolbar.h"
#import "SDAddTagViewController.h"
#import "SDNavigationController.h"

@interface SDAddTagToolbar ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic, weak) UIButton *addBtn;
/** 存放所有的标签label */
@property (nonatomic, strong) NSMutableArray *tagLabels;
@end

@implementation SDAddTagToolbar
- (NSMutableArray *)tagLabels {
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIButton *addBtn = [UIButton sd_buttonWithImage:@"tag_add_icon" highlImage:nil title:nil titleColor:nil font:0 frame:CGRectMake(SDLayoutMargin_5, 0, 0, 0) sizeToFit:YES target:self action:@selector(addButtonClick)];
    [self.topView addSubview:addBtn];
    self.addBtn = addBtn;
    
    [self createTagLabels:@[@"吐槽", @"糗事"]];
}

- (void)addButtonClick {
    SDAddTagViewController *addTagVC = [[SDAddTagViewController alloc] init];
    
    __weak __typeof(&*self) weakSelf = self;
    
    [addTagVC setTagBlock:^(NSArray *tags) {
        [weakSelf createTagLabels:tags];
    }];
    
    addTagVC.tags = [self.tagLabels valueForKeyPath:@"text"];
    
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    SDNavigationController *nav = (SDNavigationController *)root.presentedViewController;
    [nav pushViewController:addTagVC animated:YES];
}

/**
 * 创建标签
 */
- (void)createTagLabels:(NSArray *)tags {
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i < tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = SDRGB(74, 139, 209);
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = [UIFont systemFontOfSize:14];
        // 应该要先设置文字和字体后，再进行计算
        [tagLabel sizeToFit];
        tagLabel.sd_width += 2 * SDLayoutMargin_5;
        tagLabel.sd_height = self.addBtn.sd_height;
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.sd_radius = 8;
        [self.topView addSubview:tagLabel];
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i = 0; i < self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        
        if (i == 0) {
            tagLabel.sd_top = 0;
            tagLabel.sd_left = 0;
        } else {
            UILabel *lastLabel = self.tagLabels[i - 1];
            CGFloat leftWidth = lastLabel.sd_right + SDLayoutMargin_5;
            CGFloat rightWidth = self.topView.sd_width - leftWidth;
            
            if (rightWidth >= tagLabel.sd_width) {
                tagLabel.sd_left = leftWidth;
                tagLabel.sd_top = lastLabel.sd_top;
            } else {
                tagLabel.sd_left = 0;
                tagLabel.sd_top = lastLabel.sd_bottom + SDLayoutMargin_5;
            }
        }
    }
    
    UILabel *lastLabel = [self.tagLabels lastObject];
    CGFloat leftWidth =     lastLabel.sd_right + SDLayoutMargin_5;
    CGFloat rightWidth = self.topView.sd_width - leftWidth;
    
    if (rightWidth >= self.addBtn.sd_width) {
        self.addBtn.sd_left = leftWidth;
        self.addBtn.sd_top = lastLabel.sd_top;
    } else {
        self.addBtn.sd_left = 0;
        self.addBtn.sd_top = lastLabel.sd_bottom + SDLayoutMargin_5;
    }
    
    self.sd_height = self.addBtn.sd_bottom + 45;
}

@end
