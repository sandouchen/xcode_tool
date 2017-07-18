//
//  SDCenterPictureView.m
//  Category
//
//  Created by fqq3 on 17/5/2.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDCenterPictureView.h"
#import "SDShowPictureViewController.h"
#import "SDTopic.h"

@interface SDCenterPictureView ()
/** 图片 */
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/** 进度条控件 */
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation SDCenterPictureView
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
    [KEYWINDOW.rootViewController presentViewController:showPictureView animated:YES completion:nil];
}

- (void)setTopic:(SDTopic *)topic {
    _topic = topic;
    
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:topic.image1] placeholder:nil options:YYWebImageOptionSetImageWithFadeAnimation progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        
        [self.progressView setProgress:topic.pictureProgress animated:YES];
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        self.progressView.hidden = YES;
    }];
    
    self.gifView.hidden = !topic.is_gif;
    
    // 判断是否显示"点击查看全图"
    if (topic.isBigPicture) { // 大图
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else { // 非大图
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}





















@end
