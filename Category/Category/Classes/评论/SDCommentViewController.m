//
//  SDCommentViewController.m
//  Category
//
//  Created by fqq3 on 17/5/3.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDCommentViewController.h"
#import "SDTopic.h"
#import "SDTopicCell.h"
#import "SDComment.h"
#import "SDCommentSectionHeader.h"
#import "SDCommentCell.h"

static NSString *const cellID = @"SDCommentCell";
static NSString *const sectionHeaderlID = @"SectionHeader";
static const CGFloat duration = 0.25;
static const CGFloat alpha = 0.5;

@interface SDCommentViewController () <UITableViewDelegate, UITableViewDataSource, ShareButtonDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) UIView *maskView;
/** 最热评论数据 */
@property (nonatomic, strong) NSArray<SDComment *> *hotestComments;

/** 最新评论数据 */
@property (nonatomic, strong) NSMutableArray<SDComment *> *latestComments;

/** 最热评论 */
@property (nonatomic, strong) SDComment *savedTopCmt;
@property (nonatomic, strong) UIView *titleView;
@end

@implementation SDCommentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupHeader];
    [self setupRefresh];
    [self setupTableView];
    
////    [self wr_setNavBarBackgroundAlpha:0];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:(UIBarButtonItemStyleDone) target:nil action:nil];
//    
//    [self.headerImageView sd_setHeaderViewWithURL:self.topics.profile_image placeholder:@"defaultUserIcon"];
//    
//    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
//    self.titleView.backgroundColor = [UIColor greenColor];
////    UIWindow *win = KEYWINDOW;
////    win.windowLevel = UIWindowLevelAlert;
//    [self.navigationController.view addSubview:self.titleView];
//    
//    UISwitch *btn = [[UISwitch alloc] init];
//    [self.titleView addSubview:btn];
}

- (void)setupTableView {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SDCommentCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    [self.tableView registerClass:[SDCommentSectionHeader class] forHeaderFooterViewReuseIdentifier:sectionHeaderlID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 每一组头部控件的高度
    self.tableView.sectionHeaderHeight = 40;
    
    // 设置cell的高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
}

- (void)setupRefresh {
    self.tableView.mj_header = [SDRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [SDRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

#pragma mark - 数据加载
- (void)loadNewComments {
    [SDNetworkHelper cancelAllRequest];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topics.ID;
    params[@"hot"] = @1;
    
    __weak __typeof(&*self) weakSelf = self;
    
    [SDNetworkHelper GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(id responseObject) {
        // 没有任何评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 让[刷新控件]结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
            return;
        }
        
        weakSelf.hotestComments = [SDComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        weakSelf.latestComments = [SDComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        
        // 全部加载完毕
        if (weakSelf.latestComments.count >= total) {
            weakSelf.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSError *error) {
        // 如果是取消任务, 就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        [MBProgressHUD showError:[NSString stringWithFormat:@"error = %zd", (long)error.code] toView:nil];
        
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreComments {
    [SDNetworkHelper cancelAllRequest];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topics.ID;
    params[@"lastcid"] = self.latestComments.lastObject.ID;
    
    __weak typeof(self) weakSelf = self;
    
    [SDNetworkHelper GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(id responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            weakSelf.tableView.mj_footer.hidden = YES;
            return;
        }
        
        NSArray *moreComments = [SDComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.latestComments addObjectsFromArray:moreComments];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        
        // 全部加载完毕
        if (weakSelf.latestComments.count >= total) {
            // 提示用户:没有更多数据
//            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            weakSelf.tableView.mj_footer.hidden = YES;
        } else { // 还没有加载完全
            // 结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        // 如果是取消任务, 就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        [MBProgressHUD showError:[NSString stringWithFormat:@"error = %zd", (long)error.code] toView:nil];
        
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (IBAction)theRecordingClick {
    if (self.bottomSapce.constant) {
        self.bottomSapce.constant = 0;
        [self setupMaskView];
        self.recordBtn.selected = NO;
    } else {
        self.bottomSapce.constant = -200;
        [self.maskView fadeOutWithTime:duration withAlpha:alpha];
        self.recordBtn.selected = YES;
    }
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)writeComment {
    SDLogFunc;
}

- (IBAction)startTheRecording {
    [MBProgressHUD showWarn:NSLocalizedString(@"用户等级需要3级才可以使用哦~", nil) toView:nil];
}

- (void)setupMaskView {
    self.maskView = [[UIView alloc] initWithFrame:SDScreenB];
    self.maskView.backgroundColor = [UIColor blackColor];
    
    [self.view insertSubview:self.maskView belowSubview:self.bottomView];
    
    [self.maskView fadeInWithTime:duration withAlpha:alpha];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMaskView)];
    [self.maskView addGestureRecognizer:tapGesture];
}

- (void)dismissMaskView {
    [self theRecordingClick];
}

#pragma mark - 添加通知监听键盘弹出事件
- (void)addNotificationCenter {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - 监听键盘事件,底部工具条跟随键盘弹出或隐藏
- (void)keyboardWillChangeFrame:(NSNotification *)note {
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 控制器由 xib/storyboard 创建
    self.bottomSapce.constant = SDScreenH - frame.origin.y;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        // 控制器由 xib/storyboard 创建
        [self.view layoutIfNeeded];
        
        // 控制器由代码创建
//        self.view.transform = CGAffineTransformMakeTranslation(0, frame.origin.y - SCREENHEIGHT);
    }];
}

- (void)setupHeader {
    // 处理模型数据
    self.savedTopCmt = self.topics.top_cmt;
    self.topics.top_cmt = nil;
    self.topics.cellHeight = 0;
    
    // 创建header
    UIView *header = [[UIView alloc] init];
    
    SDTopicCell *headerView = [SDTopicCell sd_viewFromXib];
    headerView.topics = self.topics;
    headerView.delegate = self;
    headerView.frame = CGRectMake(0, 0, SDScreenW, self.topics.cellHeight);
    [header addSubview:headerView];
    
    header.backgroundColor = [UIColor clearColor];
    header.sd_height = headerView.sd_height + SDLayoutMargin_10 * 2;
    
    self.tableView.tableHeaderView = header;
}

- (void)didClickShareButton {
    SDLogFunc;
}

#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.hotestComments.count) return 2;
    if (self.latestComments.count) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && self.hotestComments.count)  return self.hotestComments.count;
    return self.latestComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (indexPath.section == 0 && self.hotestComments.count) {
        cell.comment = self.hotestComments[indexPath.row];
    } else {
        cell.comment = self.latestComments[indexPath.row];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SDCommentSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeaderlID];
    
    if (section == 0 && self.hotestComments.count) {
        header.textLabel.text = @"最热评论";
    } else {
        header.textLabel.text = @"最新评论";
    }
    return header;
}

#pragma mark - UITableView Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.topics.top_cmt = self.savedTopCmt;
    self.topics.cellHeight = 0;
}

@end
