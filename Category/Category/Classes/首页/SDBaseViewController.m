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

static NSString *const topicCell = @"topicCell";

@interface SDBaseViewController ()
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

- (void)setupTableView {
    // xib自定义cell-注册
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([SDTopicCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:topicCell];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(SDTitlesViewH + SDNavigationBarH, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 监听tabbar点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelect) name:SDTabBarDidSelectNotification object:nil];
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
        
    } failure:^(NSError *error) {
        NSLog(@"error = %ld", error.code);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
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
        NSLog(@"error = %ld", error.code);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
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
    
    return cell;
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
