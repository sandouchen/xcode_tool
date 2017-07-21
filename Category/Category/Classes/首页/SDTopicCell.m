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
#import "SDTopicVideoView.h"
#import "SDTopicVoiceView.h"

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
@property (nonatomic, strong) SDTopicVoiceView *topicVoiceView;

@property (nonatomic, strong) SDTopicVideoView *topicVideoView;

@end

@implementation SDTopicCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (SDCenterPictureView *)centerPictureView {
    if (!_centerPictureView) {
        _centerPictureView = [SDCenterPictureView sd_viewFromXib];
        [self.contentView addSubview:_centerPictureView];
    }
    return _centerPictureView;
}

- (SDTopicVideoView *)topicVideoView {
    if (!_topicVideoView) {
        _topicVideoView = [SDTopicVideoView sd_viewFromXib];
        [self.contentView addSubview:_topicVideoView];
    }
    return _topicVideoView;
}

- (SDTopicVoiceView *)topicVoiceView {
    if (!_topicVoiceView) {
        _topicVoiceView = [SDTopicVoiceView sd_viewFromXib];
        [self.contentView addSubview:_topicVoiceView];
    }
    return _topicVoiceView;
}

- (void)setTopics:(SDTopic *)topics {
    _topics = topics;
    
    [self.headerImageView sd_setHeaderViewWithURL:topics.profile_image placeholder:@"defaultUserIcon"];
    
    self.nameLabel.text = topics.name;
    
    self.timeLabel.text = topics.create_time;
    
    self.textLb.text = topics.text;
    
    self.sina_vImageView.hidden = !topics.sina_v;
    
    [self.dingBtn setTitle:topics.ding forState:(UIControlStateNormal)];
    [self.caiBtn setTitle:topics.cai forState:(UIControlStateNormal)];
    [self.zhuanBtn setTitle:topics.repost forState:(UIControlStateNormal)];
    [self.moreBtn setTitle:topics.comment forState:(UIControlStateNormal)];
    
    // 最热评论
    if (topics.top_cmt) { // 有最热评论
        self.topCmtView.hidden = NO;
        
        NSString *username = topics.top_cmt.user.username; // 用户名
        NSString *content = topics.top_cmt.content; // 评论内容
        
        if (topics.top_cmt.voiceuri.length) {
            content = @"[语音评论]";
        }
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    } else { // 没有最热评论
        self.topCmtView.hidden = YES;
    }
    
    
    // 中间内容
    if (topics.type == SDVideoView) { // 视频
        self.topicVideoView.hidden = NO;
        self.topicVideoView.frame = topics.contentF;
        self.topicVideoView.topic = topics;
        
        self.topicVoiceView.hidden = YES;
        self.centerPictureView.hidden = YES;
        
    } else if (topics.type == SDVoiceView) { // 音频
        self.topicVoiceView.hidden = NO;
        self.topicVoiceView.frame = topics.contentF;
        self.topicVoiceView.topic = topics;
        
        self.topicVideoView.hidden = YES;
        self.centerPictureView.hidden = YES;
        
    } else if (topics.type == SDWordView) { // 段子
        self.topicVideoView.hidden = YES;
        self.topicVoiceView.hidden = YES;
        self.centerPictureView.hidden = YES;
        
    } else if (topics.type == SDPictureView) { // 图片
        self.centerPictureView.hidden = NO;
        self.centerPictureView.frame = topics.contentF;
        self.centerPictureView.topic = topics;
        
        self.topicVideoView.hidden = YES;
        self.topicVoiceView.hidden = YES;
    }
}

- (IBAction)moreClick {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"收藏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击了[收藏]按钮");
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"举报" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击了[举报]按钮");
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击了[取消]按钮");
    }]];
    
    [KEYWINDOW.rootViewController presentViewController:actionSheet animated:YES completion:nil];
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= SDLayoutMargin_10;
    frame.origin.y += SDLayoutMargin_10;
    [super setFrame:frame];
}

@end
