//
//  TableViewController.m
//  Category
//
//  Created by fqq3 on 17/3/7.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "TableViewController.h"
#import "SDNewListModel.h"

@interface TableViewController ()
@property (nonatomic, strong) NSArray *listArray;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MJProperty mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id"};
    }];
    
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeBlack)];
    [SVProgressHUD show];
    [SDHTTPRequest newListWithList:@"list" withPer:50 withType:1 success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", responseObject);
        
        self.listArray = [SDNewListModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    SDNewListModel *listModel = self.listArray[indexPath.row];
    cell.textLabel.text = listModel.name;
    cell.detailTextLabel.text = listModel.text;
    NSString *imageURL = listModel.profile_image;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"image"]];
    
    return cell;
}


@end
