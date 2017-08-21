//
//  TableViewController.m
//  Category
//
//  Created by fqq3 on 17/3/7.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "TableViewController.h"
#import "SDNewListModel.h"
#import "SDNewListCell.h"

@interface TableViewController ()
@property (nonatomic, strong) NSArray *listArray;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubTagsData];
//    [self loadHeaderAdData];
}

- (void)loadSubTagsData {
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    CGFloat hudW = SDScreenW * 0.25;
    [SVProgressHUD setMinimumSize:CGSizeMake(hudW, hudW)];
    [SVProgressHUD show];
    
    __weak __typeof(&*self) weakSelf = self;
    
    [SDHTTPRequest recommendTagWithSuccess:^(id responseObject) {
        [SVProgressHUD dismiss];
        
        weakSelf.listArray = [SDNewListModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        [weakSelf.tableView reloadData];
        
    } andFailure:^(NSError *error) {
        // 如果是取消任务, 就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        SDLog(@"error = %ld", error.code);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

- (void)loadHeaderAdData {
//    [SDNetworkHelper setResponseSerializer:(SDResponseSerializerHTTP)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"get_top_promotion";
    parameters[@"c"] = @"topic";
    
    [SDNetworkHelper GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(id responseObject) {
        
        SDLog(@"%@", responseObject);
        
    } failure:^(NSError *error) {
        // 如果是取消任务, 就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        SDLog(@"error = %ld", error.code);
        [SVProgressHUD showErrorWithStatus:@"图片加载失败"];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"recommendTagCell";
    
    SDNewListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.listModel = self.listArray[indexPath.row];
    
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)dealloc {
    SDLog(@"控制器已销毁");
}
@end
