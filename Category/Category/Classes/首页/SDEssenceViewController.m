//
//  SDEssenceViewController.m
//  Category
//
//  Created by fqq3 on 17/4/19.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDEssenceViewController.h"
#import "SDBaseViewController.h"

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
    SDBaseViewController *all = [[SDBaseViewController alloc] init];
    all.title = @"全部";
    all.newlistType = SDAllView;
    [self addChildViewController:all];
    
    SDBaseViewController *video = [[SDBaseViewController alloc] init];
    video.title = @"视频";
    video.newlistType = SDVideoView;
    [self addChildViewController:video];
    
    SDBaseViewController *voice = [[SDBaseViewController alloc] init];
    voice.title = @"声音";
    voice.newlistType = SDVoiceView;
    [self addChildViewController:voice];
    
    SDBaseViewController *picture = [[SDBaseViewController alloc] init];
    picture.title = @"图片";
    picture.newlistType = SDPictureView;
    [self addChildViewController:picture];
    
    SDBaseViewController *word = [[SDBaseViewController alloc] init];
    word.title = @"段子";
    word.newlistType = SDWordView;
    [self addChildViewController:word];
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
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
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
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem sd_itemWithTarget:self action:@selector(toEssenceVC) image:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" insets:1];
}

- (void)toEssenceVC {
    [self performSegueWithIdentifier:@"toEssenceVC" sender:nil];
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
