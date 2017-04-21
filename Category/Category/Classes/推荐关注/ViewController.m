//
//  ViewController.m
//  Category
//
//  Created by fqq3 on 17/2/23.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import "SDRecommendLeftModel.h"
#import "SDRecommendLeftCell.h"
#import "SDRecommendRightModel.h"
#import "SDRecommendRightCell.h"

#define SDSelectedRow self.leftArray[self.leftTableView.indexPathForSelectedRow.row]

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, strong) NSArray *leftArray;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self loagingLeftList];
    [self setupRefresh];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if ([self.rightTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.rightTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.rightTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.rightTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)setupRefresh {
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.rightTableView.mj_footer.hidden = YES;
}

- (void)loadNewUsers {
    SDRecommendLeftModel *leftModel = SDSelectedRow;
    
    // 设置当前页码为1
    leftModel.currentPage = 1;
    
    // 发送请求给服务器, 加载右侧的数据
    [SDHTTPRequest recommendListWithCategory_id:leftModel.ID withPage:leftModel.currentPage Success:^(id responseObject) {
        NSArray *users = [SDRecommendRightModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清除所有旧数据
        [leftModel.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [leftModel.users addObjectsFromArray:users];
        
        // 保存总数
        leftModel.total = [responseObject[@"total"] integerValue];
        
        // 刷新右边的表格
        [self.rightTableView reloadData];
        
        // 结束刷新
        [self.rightTableView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } andFailure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        NSLog(@"%@", error);
        
        // 结束刷新
        [self.rightTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreUsers {
    SDRecommendLeftModel *leftModel = SDSelectedRow;
    
    [SDHTTPRequest recommendListWithCategory_id:leftModel.ID withPage:++leftModel.currentPage Success:^(id responseObject) {
        NSArray *users = [SDRecommendRightModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [leftModel.users addObjectsFromArray:users];
        
        [self.rightTableView reloadData];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } andFailure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        NSLog(@"%@", error);
        
        [self.rightTableView.mj_footer endRefreshing];
    }];
}

/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState {
    SDRecommendLeftModel *leftModel = SDSelectedRow;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.rightTableView.mj_footer.hidden = (leftModel.users.count == 0);
    
    // 让底部控件结束刷新
    if (leftModel.users.count == leftModel.total) {
        // 全部数据已经加载完毕
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        // 还没有加载完毕
        [self.rightTableView.mj_footer endRefreshing];
    }
}

- (void)setupTableView {
    self.leftTableView.tableFooterView = [[UIView alloc] init];
    self.rightTableView.tableFooterView = [[UIView alloc] init];
    self.rightTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightTableView.scrollIndicatorInsets = self.rightTableView.contentInset;
    self.rightTableView.rowHeight = 70;
}

- (void)loagingLeftList {
    [SDRecommendLeftModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id"};
    }];
    
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeBlack)];
    [SVProgressHUD show];
    
    [SDHTTPRequest recommendListWithSuccess:^(id responseObject) {
        [SVProgressHUD dismiss];
//        NSLog(@"%@", responseObject);
        
        self.leftArray = [SDRecommendLeftModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.leftTableView reloadData];
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:(UITableViewScrollPositionTop)];
        
        [self.rightTableView.mj_header beginRefreshing];
        
    } andFailure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        NSLog(@"%@", error);
    }];
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView)  return self.leftArray.count;
    
    // 监测footer的状态
    [self checkFooterState];
    
    return [SDSelectedRow users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        static NSString *leftCell = @"leftCell";
        
        SDRecommendLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCell];
        
        cell.recommendLeftModel = self.leftArray[indexPath.row];
        
        return cell;
    } else {
        static NSString *rightCell = @"rightCell";
        
        SDRecommendRightCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCell];
        
        cell.rightModel = [SDSelectedRow users][indexPath.row];
        
        return cell;
    }
}

#pragma mark - UITableView Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
//        [self.rightTableView.mj_header endRefreshing];
//        [self.rightTableView.mj_footer endRefreshing];
        
        SDRecommendLeftModel *leftModel = self.leftArray[indexPath.row];
        NSLog(@"%@", leftModel.name);
        
        if (leftModel.users.count) {
            [self.rightTableView reloadData];
        } else {
            // 刷新表格,目的是要马上显示当前数据,不让用户看见上一层的残留数据
            [self.rightTableView reloadData];
            
            [self.rightTableView.mj_header beginRefreshing];
        }
    } else {
        SDRecommendLeftModel *leftModel = SDSelectedRow;
        
        SDRecommendRightModel *rightModel = leftModel.users[indexPath.row];
        NSLog(@"%@", rightModel.screen_name);
    }
}

#pragma mark - 控制器的销毁
- (void)dealloc {
    // 停止所有操作
    [SDNetworkHelper cancelAllRequest];
}

































- (void)createUI {
    self.imageView.image = [[UIImage imageNamed:@"RS3"] sd_imageWithRoundedCornersAndSize:_imageView.sd_size andCornerRadius:_imageView.sd_width / 2];
    
    [_btn sd_setImagePosition:(SDImagePositionTop) spacing:5];
    
    UILabel *label = [UILabel sd_labelWithFrame:CGRectMake(20, 100, 100, 0) title:nil font:15 color:[UIColor redColor] alignment:(NSTextAlignmentCenter)];
    [label sizeToFit];
    label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:label];
    
    [UILabel sd_delLineLabel:label withColor:label.textColor];
    [UILabel sd_underlineLabel:label withColor:[UIColor blueColor]];
    [UILabel sd_labelWordSpaceWithLabel:label WordSpace:20];
    [UILabel sd_labelLineSpaceWithLabel:label LineSpace:20];
    [UILabel sd_labelSpaceWithLabel:label lineSpace:20 wordSpace:20];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem sd_itemWithTitle:@"首页" titleColor:[UIColor greenColor] Target:nil action:nil image:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" insets:ContentInstesLeft];
    
    [UIBarButtonItem sd_itemWithTarget:self action:@selector(click) image:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" insets:ContentInstesLeft];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem sd_itemWithTitle:@"设置" titleColor:[UIColor blueColor] Target:nil action:nil image:@"nav_coin_icon" highImage:@"nav_coin_icon_click" insets:(ContentInstesRight)];
    
    [UIBarButtonItem sd_itemWithTarget:self action:nil image:@"mine-setting-icon" highImage:@"mine-setting-icon-click" insets:ContentInstesRight];
    
    NSString *image = @"friendsRecommentIcon";
    NSString *hImage = @"friendsRecommentIcon-click";
    NSString *title = @"Hello World";
    
    UIButton *btn = [UIButton sd_buttonWithImage:image highlImage:hImage title:title titleColor:[UIColor redColor] font:0 frame:CGRectMake(20, 200, 0, 0) sizeToFit:NO target:nil action:nil];
    btn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    [btn sd_setImagePosition:(SDImagePositionTop) spacing:5];
    [btn sizeToFit];
    
    
    UILabel *l = [UILabel sd_labelWithFrame:CGRectMake(20, 600, 0, 0) title:@"24小时未领完，将退回" font:20 color:[UIColor blackColor] alignment:(NSTextAlignmentLeft)];
    [l sizeToFit];
    [self.view addSubview:l];
    
    UIButton *b = [UIButton sd_buttonWithTitle:@"余额" titleColor:[UIColor redColor] font:20 BackgroundColor:nil frame:CGRectZero sizeToFit:NO target:self action:@selector(click)];
    [b sizeToFit];
    b.sd_left = l.sd_right;
    b.sd_centerY = l.sd_centerY;
    b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:b];
    
    UILabel *ll = [UILabel sd_labelWithFrame:CGRectZero title:@"请留意" font:20 color:[UIColor blackColor] alignment:(NSTextAlignmentLeft)];
    [ll sizeToFit];
    ll.sd_left = b.sd_right;
    ll.sd_centerY = b.sd_centerY;
    [self.view addSubview:ll];
}

- (IBAction)click {
    TestView *testView = [TestView sd_viewFromXib];
    [self.view addSubview:testView];
    testView.frame = [UIScreen mainScreen].bounds;
    testView.backgroundColor = [HEXCOLOR(0b1746) colorWithAlphaComponent:.3];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
