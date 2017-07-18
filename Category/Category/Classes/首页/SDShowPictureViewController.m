//
//  SDShowPictureViewController.m
//  Category
//
//  Created by fqq3 on 17/4/26.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDShowPictureViewController.h"
#import "SDTopic.h"

@interface SDShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation SDShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc] init];
    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:self.imageView];
    
    CGFloat pictureW = SCREENWIDTH;
    CGFloat pictureH = pictureW * [self.topics.pictureH floatValue] / [self.topics.pictureW floatValue];
    
    if (pictureH > SCREENHEIGHT) {
        self.imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        self.imageView.sd_size = CGSizeMake(pictureW, pictureH);
        self.imageView.sd_centerY = SCREENHEIGHT * 0.5;
    }
    
    [self.progressView setProgress:self.topics.pictureProgress animated:YES];
    
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:self.topics.image1]
                                 placeholder:nil
                                     options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation
                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:YES];
                                        
                                    }
                                   transform:nil
                                  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                      self.progressView.hidden = YES;
                                  }];
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)save:(id)sender {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"Faild"];
        return;
    }
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}
@end
