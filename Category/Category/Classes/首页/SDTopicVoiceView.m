//
//  SDTopicVoiceView.m
//  Category
//
//  Created by fqq3 on 2017/7/13.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDTopicVoiceView.h"
#import "SDTopic.h"
#import "SDShowPictureViewController.h"

@interface SDTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation SDTopicVoiceView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture {
    SDShowPictureViewController *showPictureView = [[SDShowPictureViewController alloc] init];
    showPictureView.topics = self.topic;
    [SDWindowRootVc presentViewController:showPictureView animated:YES completion:nil];
}

- (void)setTopic:(SDTopic *)topic
{
    _topic = topic;
    
    NSURL *imageUrl = nil;
    
    if ([SDNetworkHelper isWWANNetwork]) {
        imageUrl = [NSURL URLWithString:topic.small_image];
    } else if ([SDNetworkHelper isWiFiNetwork]) {
        imageUrl = [NSURL URLWithString:topic.large_image];
    }
    
    [self.imageView sd_setImageWithURL:imageUrl];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
}
@end
