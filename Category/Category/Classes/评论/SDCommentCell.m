//
//  SDCommentCell.m
//  Category
//
//  Created by fqq3 on 2017/7/21.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDCommentCell.h"
#import "SDComment.h"
#import "SDUser.h"
#import "SDUserListViewController.h"
#import "SDNavigationController.h"
#import <AVFoundation/AVFoundation.h>

@interface SDCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *usernameBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@property (weak, nonatomic) IBOutlet UILabel *tieziCountLabel;
@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) IBOutlet UIImageView *playVoiceImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBottomLine;
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation SDCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
//    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
    self.tieziCountLabel.layer.cornerRadius = 3;
    self.tieziCountLabel.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toUserListView)];
    [self.tapView addGestureRecognizer:tap];
}

- (void)setComment:(SDComment *)comment {
    _comment = comment;
    [self.profileImageView sd_setHeaderViewWithURL:comment.user.profile_image placeholder:@"defaultUserIcon"];
    
    NSString *sexImageName = [comment.user.sex isEqualToString:SDUserSexMale] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexView.image = [UIImage imageNamed:sexImageName];
    
    [self.usernameBtn setTitle:comment.user.username forState:(UIControlStateNormal)];
    self.contentLabel.text = comment.content;
    
    NSUInteger random = arc4random_uniform(99999);
    if (random == 0) {
        [self.caiCountBtn setTitle:nil forState:(UIControlStateNormal)];
    } else {
        [self.caiCountBtn setTitle:[NSString stringWithFormat:@"%zd", random] forState:(UIControlStateNormal)];
    }
    
    if (comment.like_count == 0) {
        [self.likeCountBtn setTitle:nil forState:(UIControlStateNormal)];
    } else {
        [self.likeCountBtn setTitle:[NSString stringWithFormat:@"%zd", comment.like_count] forState:(UIControlStateNormal)];
    }
    
    if (random > 1000) {
        self.tieziCountLabel.text = [NSString stringWithFormat:@"%.1fk", random / 1000.0];
    } else if (random > 0) {
        self.tieziCountLabel.text = [NSString stringWithFormat:@"%zd", random];
    }
    
    if (random > 10000) {
        self.tieziCountLabel.backgroundColor = [UIColor greenColor];
    } else if (random > 1000) {
        self.tieziCountLabel.backgroundColor = [UIColor purpleColor];
    }
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        self.playVoiceImage.hidden = NO;
        self.contentBottomLine.constant = 60;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
        self.playVoiceImage.hidden = YES;
        self.contentBottomLine.constant = 15;
    }
    
    self.player = [[AVPlayer alloc] initWithPlayerItem:[[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:comment.voiceuri]]];
}

- (IBAction)listenVoice {
    [self.player play];
    
    NSInteger voiceTime = [self.voiceButton.currentTitle integerValue];
    
    // 1.1 加载所有的图片
    NSMutableArray<UIImage *> *imageArr = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        // 获取图片的名称
        NSString *imageName = [NSString stringWithFormat:@"play-voice-icon-%d_17x17_", i];
        // 创建UIImage对象
        UIImage *image = [UIImage imageNamed:imageName];
        // 加入数组
        [imageArr addObject:image];
    }
    // 设置动画图片
    self.playVoiceImage.animationImages = imageArr;
    
    // 设置动画的播放次数
    self.playVoiceImage.animationRepeatCount = voiceTime;
    
    // 设置播放时长
    self.playVoiceImage.animationDuration = 1.0;
    
    // 开始动画
    [self.playVoiceImage startAnimating];
}

- (IBAction)toUserListView {
    SDLogFunc
    
}

@end
