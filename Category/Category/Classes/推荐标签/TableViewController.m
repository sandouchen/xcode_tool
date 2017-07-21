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
    
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    CGFloat hudW = SCREENWIDTH * 0.25;
    [SVProgressHUD setMinimumSize:CGSizeMake(hudW, hudW)];
    [SVProgressHUD show];
    
    __weak __typeof(&*self) weakSelf = self;
    
    [SDHTTPRequest recommendTagWithSuccess:^(id responseObject) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            weakSelf.listArray = [SDNewListModel mj_objectArrayWithKeyValuesArray:responseObject];
            
            [weakSelf.tableView reloadData];
        });
        
    } andFailure:^(NSError *error) {
        // 如果是取消任务, 就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        NSLog(@"error = %ld", error.code);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
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
    [SDNetworkHelper cancelAllRequest];
}

- (void)dealloc {
    NSLog(@"控制器已销毁");
}
@end
