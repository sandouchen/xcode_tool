//
//  SDEssenceViewController.m
//  Category
//
//  Created by fqq3 on 17/4/19.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDEssenceViewController.h"
#import "SDAllViewController.h"
#import "SDVideoViewController.h"
#import "SDVoiceViewController.h"
#import "SDPictureViewController.h"
#import "SDWordViewController.h"

@interface SDEssenceViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
@end

@implementation SDEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupChildView];
    [self setupTitleView];
    [self setupContentView];
}

- (void)setupChildView {
    SDWordViewController *word = [[SDWordViewController alloc] init];
    word.title = @"段子";
    [self addChildViewController:word];
    
    SDAllViewController *all = [[SDAllViewController alloc] init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    SDVideoViewController *video = [[SDVideoViewController alloc] init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    SDVoiceViewController *voice = [[SDVoiceViewController alloc] init];
    voice.title = @"声音";
    [self addChildViewController:voice];
    
    SDPictureViewController *picture = [[SDPictureViewController alloc] init];
    picture.title = @"图片";
    [self addChildViewController:picture];
}

- (void)setupContentView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    [self.view insertSubview:scrollView atIndex:0];
    
    scrollView.contentSize = CGSizeMake(scrollView.sd_width * self.childViewControllers.count, 0);
    self.scrollView = scrollView;
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)setupTitleView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, SDNavigationBarH, self.view.sd_width, SDTitlesViewH)];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6f];
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.backgroundColor = [UIColor redColor];
    self.indicatorView.sd_height = 2;
    self.indicatorView.sd_bottom = titleView.sd_bottom;
    [self.view addSubview:self.indicatorView];
    
    CGFloat width = titleView.sd_width / self.childViewControllers.count;
    CGFloat height = titleView.sd_height;
    
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.sd_height = height;
        button.sd_width = width;
        button.sd_left = i * width;
        
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title  forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateDisabled)];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [titleView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedBtn = button;
            [button.titleLabel sizeToFit];
            self.indicatorView.sd_width = button.titleLabel.sd_width;
            self.indicatorView.sd_centerX = button.sd_centerX;
        }
    }
}

- (void)titleClick:(UIButton *)button {
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    [UIView animateWithDuration:.25f animations:^{
        self.indicatorView.sd_width = button.titleLabel.sd_width;
        self.indicatorView.sd_centerX = button.sd_centerX;
    }];
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = button.tag * self.scrollView.sd_width;
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)setupNav {
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.sd_width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.sd_left = scrollView.contentOffset.x;
    vc.view.sd_height = scrollView.sd_height;
    vc.view.sd_top = 0; // 设置控制器view的y值为0(默认是20)
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.sd_width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end
