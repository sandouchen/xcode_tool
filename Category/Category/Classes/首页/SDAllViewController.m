//
//  SDAllViewController.m
//  Category
//
//  Created by fqq3 on 17/4/19.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDAllViewController.h"

@interface SDAllViewController ()

@end

@implementation SDAllViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ -- %zd", [self class], indexPath.row];
    
    return cell;
}

@end
