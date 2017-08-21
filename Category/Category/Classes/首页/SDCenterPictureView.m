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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/** 进度条控件 */
@property (weak, nonatomic) IBOutlet SDProgressView *progressView;

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
    [SDWindowRootVc presentViewController:showPictureView animated:YES completion:nil];
}

- (void)setTopic:(SDTopic *)topic {
    _topic = topic;
    
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
    NSURL *imageUrl = nil;
    
    if ([SDNetworkHelper isWWANNetwork]) {
        imageUrl = [NSURL URLWithString:topic.small_image];
        SDLog(@"小图");
    } else if ([SDNetworkHelper isWiFiNetwork]) {
        imageUrl = [NSURL URLWithString:topic.large_image];
        SDLog(@"大图");
    }
    
    [self.imageView sd_setImageWithURL:imageUrl placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;

        topic.pictureProgress = 1.0 * receivedSize / expectedSize;

        [self.progressView setProgress:topic.pictureProgress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        // 如果是大图片, 才需要进行绘图处理
        if (topic.isBigPicture == NO) return;
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.contentF.size, NO, 0.0);
        
        // 将下载完的image对象绘制到图形上下文
        CGFloat width = topic.contentF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        // 获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    self.gifView.hidden = !topic.is_gif;
    
    // 判断是否显示"点击查看全图"
    if (topic.isBigPicture) { // 大图
        self.seeBigButton.hidden = NO;
//        self.imageView.contentMode = UIViewContentModeTop;
//        self.imageView.clipsToBounds = YES;
    } else { // 非大图
        self.seeBigButton.hidden = YES;
//        self.imageView.contentMode = UIViewContentModeScaleToFill;
//        self.imageView.clipsToBounds = NO;
    }
}


















@end
