//
//  SDAdViewController.m
//  Category
//
//  Created by fqq3 on 2017/8/15.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDAdViewController.h"
#import "SDAdItem.h"
#import "SDTabBarController.h"


static NSString *const code2 = @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam";

@interface SDAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
@property (nonatomic, strong) UIImageView *adView;
@property (nonatomic, strong) SDAdItem *item;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation SDAdViewController
- (UIImageView *)adView {
    if (!_adView) {
        _adView = [[UIImageView alloc] init];
        [self.adContainView addSubview:_adView];
        _adView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_adView addGestureRecognizer:tap];
        
    }
    return _adView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLaunchImage];
    [self setupJumpBtn];
    [self loadAdData];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

- (void)timeChange {
    static int time = 5;
    
    if (time == 0) {
        [self clickJump:nil];
    }
    
    time--;
    
    [self.jumpBtn setTitle:[NSString stringWithFormat:@"不看\n(%d秒)",time] forState:(UIControlStateNormal)];
}

- (IBAction)clickJump:(id)sender {
    SDTabBarController *tabBarVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([SDTabBarController class])];
    
    SDWindowRootVc = tabBarVc;
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc {
    SDLogFunc
}

#pragma mark - 加载广告数据
- (void)loadAdData {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    [SDNetworkHelper GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters success:^(id responseObject) {
        
        // 获取字典
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        
        // 字典转模型
        self.item = [SDAdItem mj_objectWithKeyValues:adDict];
        
        CGFloat h = SDScreenW / self.item.w * self.item.h;
        
        self.adView.frame = CGRectMake(0, 0, SDScreenW, h);
        
        [self.adView sd_setImageWithURL:[NSURL URLWithString:self.item.w_picurl]];
        
    } failure:^(NSError *error) {
        SDLog(@"error = %ld", error.code);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

- (void)tap {
    // 跳转到界面 => safari
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}

- (void)setupJumpBtn {
    self.jumpBtn.sd_radius = 25;
    self.jumpBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
}

// 设置启动图片
- (void)setupLaunchImage {
    if (iphone6P) { // 6p
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
        
    } else if (iphone6) { // 6
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
        
    } else if (iphone5) { // 5
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
        
    } else if (iphone4) { // 4
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
}

@end
