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
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeBlack)];
    [SVProgressHUD show];
    
    [SDHTTPRequest recommendTagWithSuccess:^(id responseObject) {
        [SVProgressHUD dismiss];
        self.listArray = [SDNewListModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
    } andFailure:^(NSError *error) {
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


@end
