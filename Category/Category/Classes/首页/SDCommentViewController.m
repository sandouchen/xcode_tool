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

@interface SDCommentViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;

@end

@implementation SDCommentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupHeader];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    CGRect frame = [note.userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.bottomSapce.constant = SCREENHEIGHT - frame.origin.y;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)setupHeader {
    // 创建header
    UIView *header = [[UIView alloc] init];
    
    SDTopicCell *cell = [SDTopicCell cell];
    cell.topics = self.topics;
    [header addSubview:cell];
    
    self.tableView.tableHeaderView = header;
}

#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %zd", indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
