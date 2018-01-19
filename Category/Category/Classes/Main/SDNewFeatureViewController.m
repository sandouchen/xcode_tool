//
//  SDNewFeatureViewController.m
//  Category
//
//  Created by fqq3 on 2017/9/6.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDNewFeatureViewController.h"
#import "SDTabBarController.h"

static NSString *const startBtnTitle = @"进   入";

#define SDImageCount 4
#define SDimageName [NSString stringWithFormat:@"%zd.jpg", i + 1]

@interface SDNewFeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation SDNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
}

#pragma mark - 初始化页面
- (void)initContentView {
    // 1.创建一个scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(scrollView.sd_width * SDImageCount, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 2.添加图片到scrollView中
    for (NSInteger i = 0; i < SDImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(scrollView.sd_width * i, 0, scrollView.sd_width, scrollView.sd_height);
        imageView.image = [UIImage imageNamed:SDimageName];
        [scrollView addSubview:imageView];
        
        // 如果是最后一个imageView，就往里面添加其他内容
        if (i == SDImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.添加pageControl：分页，展示目前看的是第几页
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = SDImageCount;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.sd_centerX = scrollView.sd_centerX;
    pageControl.sd_bottom = scrollView.sd_bottom - SDLayoutMargin_10;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

#pragma mark - 初始化最后一个imageView
- (void)setupLastImageView:(UIImageView *)imageView {
    // 开启交互功能
    imageView.userInteractionEnabled = YES;
    
    // 创建进入按钮
    UIButton *startBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    startBtn.sd_width = 150;
    startBtn.sd_height = 35;
    startBtn.sd_centerX = imageView.sd_width * 0.5;
    startBtn.sd_bottom = imageView.sd_bottom - 100;
    
    startBtn.layer.cornerRadius = 8;
    startBtn.layer.borderWidth = 1;
    startBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    [startBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [startBtn setTitle:startBtnTitle forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:startBtn];
}

- (void)startClick {
    // 切换到主控制器
    SDTabBarController *tabBarVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([SDTabBarController class])];
    
    SDWindowRootVc = tabBarVc;
}

#pragma mark - 计算当前pageControl
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat page = scrollView.contentOffset.x / scrollView.sd_width;
    
    // 四舍五入计算出页码
    self.pageControl.currentPage = (NSInteger)(page + 0.5);
}

- (void)dealloc {
    SDLogFunc;
}
@end
