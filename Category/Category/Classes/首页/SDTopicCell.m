//
//  SDTopicCell.m
//  Category
//
//  Created by fqq3 on 17/4/20.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDTopicCell.h"
#import "SDTopic.h"
#import "SDShowPictureViewController.h"
#import "SDComment.h"
#import "SDUser.h"
#import "SDCenterPictureView.h"

@interface SDTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *textLb;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhuanBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) SDCenterPictureView *centerPictureView;


@end

@implementation SDTopicCell
+ (instancetype)cell {
    return [self sd_viewFromXib];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (SDCenterPictureView *)centerPictureView {
    if (!_centerPictureView) {
        _centerPictureView = [SDCenterPictureView pictureView];
        [self.contentView addSubview:_centerPictureView];
    }
    return _centerPictureView;
}

- (void)setTopics:(SDTopic *)topics {
    _topics = topics;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:topics.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = topics.name;
    
    self.timeLabel.text = topics.create_time;
    
    self.textLb.text = topics.text;
    
    [self.dingBtn setTitle:topics.ding forState:(UIControlStateNormal)];
    [self.caiBtn setTitle:topics.cai forState:(UIControlStateNormal)];
    [self.zhuanBtn setTitle:topics.repost forState:(UIControlStateNormal)];
    [self.moreBtn setTitle:topics.comment forState:(UIControlStateNormal)];
    
    SDComment *cmt = [topics.top_cmt firstObject];
    
    if (cmt) {
        self.topCmtView.hidden = NO;
        
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
    
    if (topics.type == SDWordView) {
        if (cmt) {
            [self.textLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.topCmtView.mas_top).offset(-8);
            }];
        } else {
            [self.textLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.bottomView.mas_top).offset(-8);
            }];
        }
    } else if (topics.type == SDPictureView) {
        self.centerPictureView.topic = topics;
        
        if (cmt) {
            [self.textLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.centerPictureView.mas_top).offset(-8);
            }];
            
            [self.centerPictureView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.topCmtView.mas_top).offset(-8);
                make.left.right.equalTo(self.textLb);
                make.height.equalTo(@(topics.pictureSize.height));
            }];
            
        } else {
            [self.textLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.centerPictureView.mas_top).offset(-8);
            }];
            
            [self.centerPictureView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.bottomView.mas_top).offset(-8);
                make.left.right.equalTo(self.textLb);
                make.height.equalTo(@(topics.pictureSize.height));
            }];
        }
    }
    
    
    
    
    
    
    
    
    
}

@end
