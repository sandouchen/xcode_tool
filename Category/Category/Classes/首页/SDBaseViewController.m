//
//  SDBaseViewController.m
//  Category
//
//  Created by fqq3 on 17/4/21.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDBaseViewController.h"
#import "SDTopic.h"
#import "SDTopicCell.h"
#import "SDCommentViewController.h"
#import "SDNewViewController.h"
#import "SDNavigationController.h"
#import <Social/Social.h>

static NSString *const topicCell = @"topicCell";

@interface SDBaseViewController () <ShareButtonDelegate>
/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray<SDTopic *> *topics;
@property (nonatomic, copy) NSString *maxtime;
/** 上次选中的索引(或者控制器) */
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@end

@implementation SDBaseViewController
- (NSMutableArray<SDTopic *> *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

#pragma mark - a参数
- (NSString *)a {
    return [self.parentViewController isKindOfClass:[SDNewViewController class]] ? @"newlist" : @"list";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupRefresh];
}

- (void)showNewStatusesCount:(NSInteger)count {
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -SDTitlesViewH, self.view.sd_width, SDTitlesViewH)];
    newLabel.font = [UIFont systemFontOfSize:15];
    newLabel.textColor = [UIColor whiteColor];
    newLabel.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
    newLabel.textAlignment = NSTextAlignmentCenter;
    
    if (count > 0) {
        newLabel.text = [NSString stringWithFormat:@"又获得%zd条新消息", count];
    } else {
        newLabel.text = @"没有最新的数据";
    }
    
    [self.view addSubview:newLabel];
    
    CGFloat duration = 0.75;
    CGFloat delay = 1.0;
    
    newLabel.alpha = 0;
    
    [UIView animateWithDuration:duration animations:^{
        newLabel.transform = CGAffineTransformMakeTranslation(0, SDTitlesViewH);
        newLabel.alpha = 1;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:delay options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            newLabel.transform = CGAffineTransformIdentity;
            newLabel.alpha = 0;
            
        } completion:^(BOOL finished) {
            [newLabel removeFromSuperview];
        }];
    }];
}

- (void)setupTableView {
    // xib自定义cell-注册
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([SDTopicCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:topicCell];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(SDTitlesViewH + SDNavigationBarH, 0, 0, 0);
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    }
    
    // 监听tabbar点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelect) name:SDTabBarDidSelectNotification object:nil];
    
    // 监听标题按钮的重复点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:SDTitleButtonDidRepeatClickNotification object:nil];
}

- (void)titleButtonDidRepeatClick {
    [self tabBarSelect];
}

- (void)tabBarSelect {
    // 如果是连续选中2次, 直接刷新
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow) {
        [self.tableView.mj_header beginRefreshing];
    }
    
    // 记录这一次选中的索引
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}

- (void)setupRefresh{
    self.tableView.mj_header = [SDRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [SDRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

- (void)loadNewTopics {
    [self.tableView.mj_footer endRefreshing];
//    [SDNetworkHelper cancelAllRequest];
    
    [SDHTTPRequest newListWithType:self.newlistType andMaxtime:nil andList:self.a success:^(id responseObject) {
        // 存储maxtime(方便用来加载下一页数据)
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [SDTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        [self showNewStatusesCount:self.topics.count];
        
    } failure:^(NSError *error) {
        // 如果是取消任务, 就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        [MBProgressHUD showError:[NSString stringWithFormat:@"error = %zd", (long)error.code] toView:nil];
        
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics {
    [self.tableView.mj_header endRefreshing];
    
    [SDHTTPRequest newListWithType:self.newlistType andMaxtime:self.maxtime andList:self.a success:^(id responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray<SDTopic *> *moreTopic = [SDTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:moreTopic];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        // 如果是取消任务, 就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        [MBProgressHUD showError:[NSString stringWithFormat:@"error = %zd", (long)error.code] toView:nil];
        
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCell];
    
    cell.topics = self.topics[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

- (void)didClickShareButton {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"系统分享" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController *comVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            comVC.completionHandler = ^(SLComposeViewControllerResult result) {
                if (result == SLComposeViewControllerResultCancelled) {
                    [MBProgressHUD showWarn:NSLocalizedString(@"取消分享", nil) toView:nil];
                    
                } else {
                    [MBProgressHUD showInfo:NSLocalizedString(@"分享成功", nil) toView:nil];
                }
            };
            
            [self presentViewController:comVC animated:YES completion:nil];
            
        } else {
            [MBProgressHUD showWarn:NSLocalizedString(@"还没有对应账号", nil) toView:nil];
        }
        SDLog(@"点击了[收藏]按钮");
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"友盟分享" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        __weak __typeof(&*self) weakSelf = self;
        
        //显示分享面板
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            if (platformType == UMSocialPlatformType_WechatSession) {
                [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
                
            } else if (platformType == UMSocialPlatformType_Sina) {
                [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_Sina];
                
            } else if (platformType == UMSocialPlatformType_WechatTimeLine) {
                [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
                
            } else if (platformType == UMSocialPlatformType_QQ) {
                [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_QQ];
            }
        }];
        
        SDLog(@"点击了[举报]按钮");
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType {
    [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建音乐内容对象
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"RS3"]];
    //设置音乐网页播放地址
    shareObject.musicUrl = @"http://c.y.qq.com/v8/playsong.html?songid=108782194&source=yqq#wechat_redirect";
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            SDLog(@"************Share fail with error %@*********",error);
        }else{
            SDLog(@"response data is %@",data);
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SDCommentViewController *commentVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([SDCommentViewController class])];
    
    commentVC.topics = self.topics[indexPath.row];
    
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.topics[indexPath.row].cellHeight;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
