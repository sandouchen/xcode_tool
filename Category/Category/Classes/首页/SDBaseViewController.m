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

static NSString *const topicCell = @"topicCell";

@interface SDBaseViewController ()
@property (nonatomic, strong) NSMutableArray *topics;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *maxtime;
@end

@implementation SDBaseViewController
- (NSMutableArray *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
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
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(SDTitlesViewH + SDNavigationBarH, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

- (void)loadNewTopics {
    [self.tableView.mj_footer endRefreshing];
    
    [SDHTTPRequest newListWithList:@"list" withPage:0 withType:self.newlistType withMaxtime:nil success:^(id responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [SDTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        // 清空页码
        self.page = 0;
    } failure:^(NSError *error) {
        NSLog(@"error = %@", error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics {
    [self.tableView.mj_header endRefreshing];
    
    self.page++;
    
    [SDHTTPRequest newListWithList:@"list" withPage:self.page withType:self.newlistType withMaxtime:self.maxtime success:^(id responseObject) {
        NSLog(@"%@", responseObject);
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *moreTopic = [SDTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:moreTopic];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@", error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.tableView.mj_footer endRefreshing];
        
        self.page--;
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

@end
